Message-ID: <4ACE02FF.1090709@domain.hid>
Date: Thu, 08 Oct 2009 17:19:27 +0200
From: Peter Puchwein <peter.puchwein@domain.hid>
MIME-Version: 1.0
References: <1255014185.4690.56.camel@domain.hid> <4ACE0018.20705@domain.hid>
In-Reply-To: <4ACE0018.20705@domain.hid>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: Re: [Xenomai-help] rt_print segfault on program termination
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> Christoph Permes wrote:
>> Hi,
>>
>> We use a vmware virtual machine for simulation and testing our realtime
>> applications.
>> Every time when a realtime application terminates the following core
>> dump occures:
>>
>> Program terminated with signal 11, Segmentation fault.
>> [New process 11728]
>> [New process 11726]
>> [New process 11727]
>> #0  0xb7e3e675 in free () from /lib/libc.so.6
>> (gdb) bt
>> #0  0xb7e3e675 in free () from /lib/libc.so.6
>> #1  0xb80551dd in cleanup_buffer (buffer=0x81dd210) at rt_print.c:350
>> #2  0xb7dbee27 in __nptl_deallocate_tsd () from /lib/libpthread.so.0
>> #3  0xb7dbff49 in start_thread () from /lib/libpthread.so.0
>> #4  0xb7e9cb6e in clone () from /lib/libc.so.6
>>
>> The line where the segfault occures is
>> free(buffer->ring);
>>
>> The segfault never happens when running on a real machine, so it's no
>> problem when running in production, but it is annoying when every run in
>> the test environment leads to a segmentation fault.
>>
>> Maybe it is a timing related issue as there are no problems on a real
>> machine.
> 
> Did you found the issue that was causing segmentation faults, or did you
> keep your workaround?
> 

We kept our workaround, because we need an rt_print without 
mode-switching the realtime-task.
With the mode-switching version we didn't get any errors, so we couldn't 
find out more details about the error.
But it seems that there is a time-bounded issue in rt_print, depending 
on the speed of the system.

Peter



