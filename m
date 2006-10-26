Message-ID: <45406FEF.90806@domain.hid>
Date: Thu, 26 Oct 2006 10:21:03 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] switchtest and Xenomai 2.2.4
References: <1160947939.4962.27.camel@domain.hid> <453FC4C0.5070105@domain.hid>
	<453FF6AA.6030406@domain.hid>
In-Reply-To: <453FF6AA.6030406@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jeff Webb <jeff.webb@domain.hid>
Cc: xenomai@xenomai.org

Jeff Webb wrote:
> Jeff Webb wrote:
> 
>> When I upgraded to Xenomai 2.2.4, I tried the switchtest program:
>>
>>  cd /usr/xenomai/testsuite/switchtest
>>  ./run
>>
>> The program appeared to run properly, but <ctrl>-c would not stop the 
>> application.  I was not able to kill the process cleanly, and 
>> /proc/xenomai/stat showed lots of processes still running.
> 
> 
> I get the same result with svn trunk (rev 1749) plus this FPU patch:
> 
>  https://mail.gna.org/public/xenomai-core/2006-10/msg00069.html
> 
> I think the bug may be SMP related.  When I press <ctrl>-c the first 
> time, I see no more references to CPU 0.  When I press <ctrl>-c a second 
> time, all output stops.  I have attached the output below.
> 

Are you using NPTL or Linuxthreads ? Could you tell us in what state the
switchtest threads are when running ps and in /proc/xenomai/sched ?
After the second Ctrl-C, are the threads still alive ?

Since after the first Ctrl-C, CPU 0 switches are no longer displayed,
the program probably started the cleanup correctly; if gdb does not
tell you where the main thread is blocked, could you try adding some
printfs in the main thread ?

-- 
                                                  Gilles Chanteperdrix

