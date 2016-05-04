Date: Wed, 4 May 2016 23:00:30 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160504210030.GK1761@hermes.click-hack.org>
References: <2396B4D2166B62479FBBE370D4A7C1F30A733197@mb2010-3.intra.tut.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2396B4D2166B62479FBBE370D4A7C1F30A733197@mb2010-3.intra.tut.fi>
Subject: Re: [Xenomai] mmap a file in rtdm moudle without switching the mode
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Umair Ali <ali.umair@tut.fi>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Wed, May 04, 2016 at 01:03:35PM +0000, Umair Ali wrote:
> Hello ,
> 
> My aim is to open and read a file in the rtdm module. This file will be accessed or red  periodically using the kernel timers until the whole file is read completely. What I am doing is as follows
> - Open the file and mapped the file using mmap() in the user space in real time.
> -  a kernel module is running in the back ground with timer initialized
> -  run the application in user space and pass the mmap pointer along with the size of file to the kernel module by using the read() function to read the device.
> - In the read_rt thread of module the pointer of the mapped file is assigned to the global  char pointer and timer is started.
> - The timed function is using the global char pointer to access file but fails when the read_rt ends
> - Meanwhile the user space app is also ended after passing the pointer and file size.
> 
> The above technique is not working because when the read_rt ends then the kernel is stuck. I have read on the net that I should pass the pointer of mmaped file from userspace to the kernel space as mmap is ponting the file to kernel memory. It seems to me that memory is erased once the user space app or read_rt in module ends. Please guide me if I am on the right path or what should I do so that I can read the file in the module and read periodically using kernel timer. Is there any rtdm functions which I have missed and can help me. 

No, you are not on the right track. I do not understand the problems
you have, I believe I understand what you are trying to achieve, but
I do not see an easy angle to give you the lot of information you
lack. I believe reading "linux device drivers" would be in order to
have a little understanding of how a standard linux driver works and
is implemented, then read the RTDM API documentation to understand
how to replace Linux kernel functions with their RTDM equivalent.

-- 
					    Gilles.
https://click-hack.org

