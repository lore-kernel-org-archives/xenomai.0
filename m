From: Robert Berger <gmane@domain.hid>
Date: Thu, 01 Apr 2010 07:26:15 +0300
Message-ID: <hp179e$1aj$1@domain.hid>
References: <hp0bdv$mp4$1@domain.hid>	<4BB3BCF9.9080809@domain.hid>
	<20100331231236.75D8AE73028@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
In-Reply-To: <20100331231236.75D8AE73028@domain.hid>
Subject: Re: [Xenomai-help] cyclictest -tn where n!=1 causes segfault with
	Kilauea
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

Hi Wolfgang,

Wolfgang Denk wrote:
> Dear Robert,
> 
> In message <4BB3BCF9.9080809@domain.hid> you wrote:
>> ulimit -s
>> 8192
> 
> And what happens when you start cyclictest after running
> "ulimit -s unlimited" ?

ulimit -s unlimited
-bash-3.2# ./cyclictest -t3
Segmentation fault

We are still dying somewhere here:

Program terminated with signal 11, Segmentation fault.
#0  0x0ff4e37c in xeno_fault_stack ()
   from /usr/local/xenomai-head/lib/libxenomai.so.0
(gdb)


Regards,

Robert
> 
> Best regards,
> 
> Wolfgang Denk
> 


