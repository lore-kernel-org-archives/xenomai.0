In-Reply-To: <20090116163634.2C8C11C066@domain.hid>
From: stefano.franzoni@domain.hid
Date: Mon, 19 Jan 2009 11:55:42 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Message-Id: <20090119105545.05F1C1C066@domain.hid>
Subject: Re: [Xenomai-help] malloc greater than 4K issue
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: stefano.franzoni@domain.hid
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>, xenomai-help-bounces@domain.hid

Issue solved.
Sinuous bug into my application!

Stefano



                                                                           
             stefano.franzoni@                                             
             marposs.com                                                   
             Sent by:                                                   To 
             xenomai-help-boun         "xenomai@xenomai.org"              
             ces@domain.hid               <xenomai@xenomai.org>              
                                                                        cc 
                                                                           
             16/01/2009 17:36                                      Subject 
                                       [Xenomai-help] malloc greater than  
                                       4K issue                            
                                                                           
                                                                           
                                                                           
                                                                           
                                                                           
                                                                           





Dear experts

we have a systems with Ubuntu Linux 2.6.25.11 and Xenomai 2.4.4.
The system has a Pentium III (Coppermine) 1GHz.
The Xenomai installation seems to be ok.

The application, in an Rt task in user mode, allocates and uses a buffer of
4K or greater.
The buffer is allocated with malloc.

When the buffer is greater that 4K the progam exits with a sementation
fault.

I have no idea of the origin of the issue.
I ask you if the use of malloc for buffer greater than 4K is correct or the
use of other APIs is suggested.
I have tried also with rt_heap_create but I receive an error of "permission
denied".

Any suggestions?

Thanks in advance

Stefano


_______________________________________________
Xenomai-help mailing list
Xenomai-help@domain.hid
https://mail.gna.org/listinfo/xenomai-help



