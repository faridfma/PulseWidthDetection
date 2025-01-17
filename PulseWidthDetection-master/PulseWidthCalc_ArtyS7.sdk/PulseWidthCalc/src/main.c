/******************************************************************************/
/**
*
* File: UARTLite_test.c
*
* Description: example of minimal Tx testing of the UART Lite core v2.0, and sends
*              the entire english alphabet at 9600 Buad, 8 data bits, no parity,
*
* Notes:
*
*
* MODIFICATION HISTORY:
* <pre>
* Ver   Who  Date	 Changes
* ----- ---- -------- -----------------------------------------------
* 1.00a DM   8/12/21  First release
* </pre>
******************************************************************************/

/***************************** Include Files *********************************/

#include "platform.h"
#include "xil_printf.h"
#include "xstatus.h"
#include "xparameters.h"
#include "xuartlite.h"
#include "xbasic_types.h"
#include "sleep.h"
/************************** Constant Definitions *****************************/

#define UARTLITE_DEVICE_ID  XPAR_UARTLITE_0_DEVICE_ID

// 26 letters in alphabet
#define TX_DATA_SIZE  26

// max size in non-interrput mode
#define TX_BUFF_SIZE  16


#define  TIMESTEP_NS        2.5



/************************** Function Prototypes ******************************/

int UARTLite_Init(u16 DeviceID);
int SendData(u8 *TxDataPointer, u8 *TxDataBufferPointer);

/************************** Variable Definitions *****************************/

// instance of UART Lite core
XUartLite UartLite0;

Xuint32 *baseaddr_p = (Xuint32 *)XPAR_PULSEIP_0_S00_AXI_BASEADDR;







int main()
{
  unsigned int period_ns =0;
  unsigned int PulseFrequency = 0;

  unsigned int debugValue =0;
  unsigned int temp =0;
  unsigned int temp2 =0;

  static unsigned char counter =0;


  //unsigned int array[1000]={0};

  int UartLiteStatus;
  init_platform();

  UartLiteStatus = UARTLite_Init(UARTLITE_DEVICE_ID);

  xil_printf("UART test successful\n\r");

  while(1)
  {

		  //data is ready read pulse length
		  period_ns = *(baseaddr_p+2);
		  period_ns = 2*period_ns*TIMESTEP_NS;
		 // xil_printf("pulse count in nanoseconds is %d\n\r", period_ns);
		  PulseFrequency = 1000000000/period_ns;
		  xil_printf("frequency in Hertz is %d\n\r",   PulseFrequency);
		  //expected count for 1Mhz is 400
		  period_ns = *(baseaddr_p+2);

		  xil_printf("count of clock sizes is: %d\n\r", period_ns);

		  xil_printf("expected count for 1Mhz is 200\n\r");
		  period_ns = period_ns - 200;
		  xil_printf("error is %d\n\r",  period_ns);


		 //go to sleep for 1 second
		 sleep(1);

  }

  xil_printf("End of test\n\n\r");

  cleanup_platform();
  return XST_SUCCESS;
}


/*****************************************************************************/
/**
*
* Description: Initializes UART Lite and does a self test
*
*
* Arguments: DeviceID is the DeviceId is the Device ID of the UartLite and is the
*		         XPAR_<uartlite_instance>_DEVICE_ID value from xparameters.h.
*
*
* Returns: XST_SUCCESS if successful, otherwise XST_FAILURE.
*
*
* Notes:
*
******************************************************************************/
int UARTLite_Init(u16 DeviceID)
{
  int Status;

  // perform initialization tests
  Status = XUartLite_Initialize(&UartLite0, DeviceID);
  if (Status != XST_SUCCESS)
  {
    return XST_FAILURE;
  }

  // perform self-test tests
  Status = XUartLite_SelfTest(&UartLite0);
  if (Status != XST_SUCCESS)
  {
    return XST_FAILURE;
  }

  return XST_SUCCESS;
}


/*****************************************************************************/
/**
*
* Description: This function is responsible for data transmission
*
*
* Arguments: DataPointer is a ptr to the data that needs to be sent out
*            DataBufferPointer is the pointer the 16 byte Tx buffer
*
*
* Returns: XST_SUCCESS if successful, otherwise XST_FAILURE.
*
*
* Notes:
*
******************************************************************************/
int SendData(u8 *TxDataPointer, u8 *TxDataBufferPointer)
{
  unsigned int TxBytesSent;

  // max data sent per function call is 16 bytes (size of FIFOs)
  while (TxBytesSent != TX_DATA_SIZE)
  {
    // put only 16 bytes of data into Tx_buff
    for(int i = 0; i < TX_BUFF_SIZE; i++)
    {
      TxDataBufferPointer[i] = TxDataPointer[TxBytesSent+i];
    }

  // Send buffer
    TxBytesSent += XUartLite_Send(&UartLite0, TxDataBufferPointer, TX_BUFF_SIZE);
  }

  // make sure all data was sent out
  if (TxBytesSent != TX_DATA_SIZE)
  {
   return XST_FAILURE;
  }

  xil_printf("\n\r");
  return XST_SUCCESS;
}

