From: Alexis Berlemont <berlemont.hauw@domain.hid>
Date: Fri, 21 Sep 2007 00:36:51 +0200
References: <200709201549.13035.lepalom@domain.hid>
In-Reply-To: <200709201549.13035.lepalom@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200709210036.51949.berlemont.hauw@domain.hid>
Subject: Re: [Xenomai-help] Comedi driver for use with xenomai
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

> some time ago, Alexis Berlemont posted this message [1] about the
> possibility to use a comedi (or modified) driver with xenomai .
>
> My question is: there's a driver in comedi that I would like to use with
> xenomai. Is this possible?

Currently, the RTDM version of Comedi supports only test drivers. I have tried 
to port some NI drivers just so as to ensure that my Comedi infrastructure 
was coherent.

However, if you want to add a new driver which comes from the original Comedi 
set, there will be little work to do as the API has changed a little bit.

Which driver is it ? 

You may have noticed that I am still developing Comedi4RTDM. I have decided to 
start from scratch in order to make the most of the RTDM advantages. The 
drawback is, for me, is the time needed to perform such a task (according to 
my private schedule). 

Because of many issues, it's been while since I committed on the Comedi branch 
(too many bugs/instabilities, lack of time, etc.). I will send many fixes / 
changes / adds (notably a minimal version of a NI driver) the next week.

I hope that will help you.

By the way, if you (or anyone else) are interested in working in this 
mini-project, assessing it or just giving your opinion on the subject, please 
let me know.

Best regards.

Alexis.


