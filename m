Message-ID: <1214472123.48635fbbca3f3@domain.hid>
Date: Thu, 26 Jun 2008 11:22:03 +0200
From: nourry@domain.hid
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] Daq System Compatibility
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

Hi,

> That seems to be an example showing how to use the driver. That will no=
t help
> us to write the driver. The hardware access are abstracted / encapsulat=
ed by
> DAQmx functions.


Alex, do you think this sample looks more like a driver ?
It comes from NI Development Kit and i saw on NI forum that someone was
developing a driver from that sources for a PCI card in order to make it =
work
under Xenomai. He had some problems but he seems to manage to initialize =
the
card and program interrupts.

//

//  common.cpp

//

//  $DateTime: 2006/07/27 23:51:45 $

//

#include "common.h"


void analogTriggerReset (tMSeries* board)

{

    board->Analog_Trigger_Etc.setAnalog_Trigger_Reset(1);

  =20
board->Analog_Trigger_Etc.setAnalog_Trigger_Mode(tMSeries::tAnalog_Trigge=
r_Etc::kAnalog_Trigger_ModeLow_Window);

    board->Analog_Trigger_Etc.flush();



  =20
board->Analog_Trigger_Control.setAnalog_Trigger_Select(tMSeries::tAnalog_=
Trigger_Control::kAnalog_Trigger_SelectGround);

    board->Analog_Trigger_Control.flush();



    board->Gen_PWM[0].writeRegister(0);

    board->Gen_PWM[1].writeRegister(0);



  =20
board->Analog_Trigger_Etc.setAnalog_Trigger_Enable(tMSeries::tAnalog_Trig=
ger_Etc::kAnalog_Trigger_EnableDisabled);

    board->Analog_Trigger_Etc.flush();



    return;

}


Thank you,
Antoine

