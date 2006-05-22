Content-class: urn:content-classes:message
Message-ID: <4471A286.90500@domain.hid>
Date: Mon, 22 May 2006 13:37:42 +0200
From: "Nathan Lauener" <nathan.lauener@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] CPU load over 90%[Scanned]
References: <AD78122AD7C05B4B936EBAD7F49738C0AB2B3D@square.bfh.ch>
	<44686D9B.2010509@domain.hid> <4469C85C.7060900@domain.hid>
	<4469CB20.9030909@domain.hid> <446AEB37.6090505@domain.hid>
	<446B0156.4000004@domain.hid>
In-Reply-To: <446B0156.4000004@domain.hid>
Content-Type: text/plain;
	format=flowed;
	charset="ISO-8859-15"
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org



Jan Kiszka wrote:

>Nathan Lauener wrote:
>  
>
>>Jan Kiszka wrote:
>>
>>    
>>
>>>Nathan Lauener wrote:
>>> 
>>>
>>>      
>>>
>>>>Jan Kiszka wrote:
>>>>
>>>>  
>>>>        
>>>>
>>>>>Lauener Nathan wrote:
>>>>>
>>>>>
>>>>>    
>>>>>          
>>>>>
>>>>>>Hi, I am using Xenomai to read data from different sensors in real
>>>>>>time from
>>>>>>user space. So far I am reading position data from a device
>>>>>>attached to
>>>>>>a serial port. The CPU load is at about 1%. I also have a
>>>>>>microcontroller attached via USB to read encoder data. The USB
>>>>>>device is
>>>>>>a USB-to-serial converter. As soon as I open the (USB-)serial port
>>>>>>with
>>>>>>normal systemcalls and read the incoming data my CPU load
>>>>>>skyrockets to
>>>>>>over 90%. I only read about 30 bytes every 100ms.
>>>>>>I ran the application on a much newer computer also to rule out any
>>>>>>buggy hardware. The results stayed the same. Intensively searching the
>>>>>>mailing list and provided documentation have not helped solve the
>>>>>>problem. I'm using Xenomai 2.1.0 with kernel 2.6.15.6. Xenomai is
>>>>>>compiled into
>>>>>>the kernel. I also use the driver xeno_16550A loaded as module. The
>>>>>>USB-to-serial bridge used is a CP2101 from Silabs.         
>>>>>>            
>>>>>>
>>>>>Is there any IRQ conflict between the USB host controller and some
>>>>>RT-device? Please check /proc/interrupts and /proc/xenomai/irq.
>>>>>
>>>>>
>>>>>    
>>>>>          
>>>>>
>>>>There is no conflict (interrupt 0 (timer) is the only interrupt
>>>>mentioned in both listings).
>>>>  
>>>>        
>>>>
>>>Ok, just to exclude this.
>>>
>>> 
>>>
>>>      
>>>
>>>>>Which process is consuming your CPU time? At system or at user level?
>>>>>
>>>>>
>>>>>    
>>>>>          
>>>>>
>>>>It seems that the system consumes the CPU time. Here are the first few
>>>>lines from opreport
>>>>
>>>>CPU: CPU with timer interrupt, speed 0 MHz (estimated)
>>>>Profiling through timer interrupt
>>>>samples  %        image name               app name               
>>>>symbol name
>>>>1733     31.9742  vmlinux                  vmlinux                
>>>>default_idle
>>>>1151     21.2362  vmlinux                  vmlinux                
>>>>__ipipe_trace
>>>>601      11.0886  libqt-mt.so.3.3.3        libqt-mt.so.3.3.3        (no
>>>>symbols)
>>>>528       9.7417  libc-2.3.2.so            libc-2.3.2.so            (no
>>>>symbols)
>>>>305       5.6273  vmlinux                  vmlinux                
>>>>__ipipe_unstall_root
>>>>184       3.3948  vmlinux                  vmlinux                
>>>>__ipipe_dispatch_event
>>>>122       2.2509  anon (tgid:4322 range:0x81fb000-0x89b2000)
>>>>Xorg                     (no symbols)
>>>>100       1.8450  libstdc++.so.5.0.7       libstdc++.so.5.0.7       (no
>>>>symbols)
>>>>97        1.7897  vmlinux                  vmlinux                 
>>>>mcount
>>>>
>>>>It looks like the systems gets stuck on the idle task. I do not know
>>>>what __ipipe_trace exactly does.
>>>>  
>>>>        
>>>>
>>>__ipipe_trace belongs to the ipipe-tracer you seem to have patched into
>>>your system. It's called on EVERY kernel function's entry, so it should
>>>show up on higher ranks. Disable the tracer first to get a more
>>>consistent profile.
>>>
>>> 
>>>
>>>      
>>>
>>>>>Jan
>>>>>
>>>>>
>>>>>
>>>>>    
>>>>>          
>>>>>
>>>>In my current design I acquire and process the data in the same programm
>>>>using the Xenomai native skin from user space. This means I link the
>>>>Xenomai-native and rtdm libraries with several graphics and mathematical
>>>>libraries. Could this lead to conflicts or problems with Xenomai?
>>>>  
>>>>        
>>>>
>>>Should not, we do the same here (e.g. with opencv). Anyway, reducing
>>>your scenario to the minimum that still performs badly can help to
>>>identify the reason.
>>> 
>>>
>>>      
>>>
>>I compiled a reduced version of my programm and also recompiled the
>>kernel with tracing switched off. Running it 'top' outputs 40% us, 60%
>>sys, 0% id => 100% CPU load.
>>    
>>
>
>Strange.
>
>  
>
>>'opreport' ouput looks a follows
>>
>>CPU: CPU with timer interrupt, speed 0 MHz (estimated)
>>Profiling through timer interrupt
>>samples  %        image name               app name                
>>symbol name
>>2517     37.4944  vmlinux                  vmlinux                 
>>default_idle
>>    
>>
>
>Almost 40% idle but still 100% loaded? Did anyone else see top&friends
>being confused by the presence of Xenomai? I did not so far.
>
>  
>
>>496       7.3886  libc-2.3.2.so            libc-2.3.2.so            (no
>>symbols)
>>385       5.7351  vmlinux                  vmlinux                 
>>__ipipe_dispatch_event
>>364       5.4223  vmlinux                  vmlinux                 
>>__ipipe_unstall_root
>>323       4.8116  vmlinux                  vmlinux                 
>>read_chan
>>269       4.0072  libstdc++.so.5.0.7       libstdc++.so.5.0.7       (no
>>symbols)
>>246       3.6645  vmlinux                  vmlinux                 
>>sysenter_past_esp
>>155       2.3090  anon (tgid:4245 range:0x81fb000-0x89a4000)
>>Xorg                     (no symbols)
>>115       1.7131  vmlinux                  vmlinux                 
>>fget_light
>>104       1.5492  vmlinux                  vmlinux                 
>>vfs_read
>>100       1.4896  libpthread-0.60.so       libpthread-0.60.so      
>>__pthread_disable_asynccancel
>>98        1.4599  vmlinux                  vmlinux                 
>>add_wait_queue
>>97        1.4450  libpthread-0.60.so       libpthread-0.60.so      
>>__read_nocancel
>>93        1.3854  3Dpos                    3Dpos                   
>>SerialportReader::run()
>>93        1.3854  libpthread-0.60.so       libpthread-0.60.so      
>>__pthread_enable_asynccancel
>>91        1.3556  vmlinux                  vmlinux                 
>>__ipipe_test_and_stall_root
>>87        1.2960  vmlinux                  vmlinux                 
>>tty_ldisc_deref
>>85        1.2662  vmlinux                  vmlinux                 
>>remove_wait_queue
>>68        1.0130  vmlinux                  vmlinux                 
>>__wake_up
>>68        1.0130  vmlinux                  vmlinux                 
>>sys_read
>>66        0.9832  vmlinux                  vmlinux                 
>>__ipipe_restore_root
>>65        0.9683  vmlinux                  vmlinux                 
>>tty_read
>>62        0.9236  vmlinux                  vmlinux                 
>>tty_ldisc_try
>>55        0.8193  vmlinux                  vmlinux                 
>>rw_verify_area
>>54        0.8044  vmlinux                  vmlinux                 
>>__ipipe_syscall_root
>>
>>    
>>
>
>So, on which system service does your application spin then?
>read(ttyUSBx)? What is the error code of the service that returns
>probably too often? Maybe some timing assumptions of your usb2serial
>driver get violated by the presence of the real-time core.
>
>  
>
I let my application run but read the USB-serial port using Gtkterm at 
the same time. CPU load was at about 3%. This rules out a driver problem 
or conflict between Linux and Xenomai or related. I guess I should have 
a close look at my realtime/non realtime interactions.
Unfortunately other hardware related problems with the USB sub system 
forced us to not use USB for the time beeing. If I should further 
investigate the problem and find anything interesting I will of course 
let you know.
Thanke you very much for your generous support and donation of time.

Nathan

>Jan
>
>  
>

