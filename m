Message-ID: <793108.19562.qm@domain.hid>
Date: Tue, 8 Sep 2009 10:10:57 -0700 (PDT)
From: Guvenc Gulce <gulceg@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Xenomai-help] RT Task RPC over a POSIX/Native Queue
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

Hi 
As far as I know an Xenomai RT Task can not call Linux API functions without leaving the Xenomai domain.

I was thinking about a generic library/framework which would allow an Xenomai RT Task call a Linux API 
function which would be then marshalled over a Posix/Native Queue to another Xenomai RT Task which then 
would do the dirty job of calling Linux functions. The responses and function return values from linux functions 
can be marshalled back to the original Xenomai RT-Task caller again over another Posix/Native Queue. In such 
a scenario the original caller RT Task would stay always in Xenomai domain. 

I would like to hear whether such an approach sounds feasible/reasonable given the fact that currently 
Xenomai RT Tasks can not call Linux functions without leaving the Xenomai domain. Such a library/framework 
would be a solution to overcome that constraint. I would be glad to hear some opinions about this.

Thanks & Regards,

Guvenc  


      


