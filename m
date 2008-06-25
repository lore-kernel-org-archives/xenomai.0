Content-Disposition: inline
From: Alexis Berlemont <berlemont.hauw@domain.hid>
Date: Thu, 26 Jun 2008 00:46:31 +0200
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200806260046.31662.berlemont.hauw@domain.hid>
Subject: [Xenomai-help] Fwd: Re:  Daq System Compatibility
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Second try: 

Hi,

> i have found examples from the C interface of the official NI Linux
> driver (Alex asked for it) :
>
> * Description:
> *    This example demonstrates how to read values from a digital input
> *    channel.
>
> #include "NIDAQmxBase.h"
> #include <stdio.h>
>
> #define DAQmxErrChk(functionCall) { if(
> DAQmxFailed(error=(functionCall)) ) { goto Error; } }
>
> int main (int argc, char *argv[])
> {
>    // Task parameters
>    int32       error = 0;
>    TaskHandle  taskHandle = 0;
>    char        errBuff[2048];
>
>    // Channel parameters
>    const char  chan[] = "Dev1/port0";
>
>    // Read parameters
>    uInt32      r_data [1];
>    int32       read;
>
>    // Create Digital Input (DI) Task and Channel
>    DAQmxErrChk (DAQmxBaseCreateTask ("", &taskHandle));
>    DAQmxErrChk
> (DAQmxBaseCreateDIChan(taskHandle,chan,"",DAQmx_Val_ChanForAllLines));
>

That seems to be an example showing how to use the driver. That will not help 
us to write the driver. The hardware access are abstracted / encapsulated by 
DAQmx functions.

I had a look at NI website, the DAQmx framework and its associated drivers set  
(among them the one for the 6218 device) are some closed source package.

The only solution left to us is to write the Comedi driver thanks to the 
hardware specifications of the acquisition component. However, I do not think 
such documentations are freely available (I hope I am wrong).

> Does it look like something common and possibly portable to RTDM/COMEDI?
> Where can we find documentation on that comedi rtdm port ?

I think the DAQmx framework and Comedi fulfill the same role, they provide 
some user-friendly features to manage acquisitions devices, a generic API is 
available so as to quickly develop acquisition software applications. Such 
programs are based on the Comedi user API; another API, the Comedi driver 
API, must be used so as to write the Comedi kernel driver.

In our case, no Comedi driver for NI 6218 has been released (yet).

Best regards.

Alexis.

-------------------------------------------------------



