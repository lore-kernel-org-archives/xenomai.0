Sender: Alexis Berlemont <alexis.berlemont@domain.hid>
Message-ID: <4B9ADF5C.5060306@domain.hid>
Date: Sat, 13 Mar 2010 01:42:04 +0100
From: Alexis Berlemont <berlemont.hauw@domain.hid>
MIME-Version: 1.0
References: <4B990EF1.1000400@domain.hid>
In-Reply-To: <4B990EF1.1000400@domain.hid>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Experimenting with Analogy. Bugs found?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Daniele Nicolodi <daniele@domain.hid>
Cc: xenomai@xenomai.org

Hi,

Daniele Nicolodi wrote:
> Hello. I'm testing Analogy on my x86 system with a NI 6251 ADC board (I
> can test with other NI ADCs if it useful to someone).
> 
> The lack of overview documentation is making my progress slow, but I
> have a couple of acquisition routines working quite well.

Which documentation are talking about ? For me the docs are:
- the Doxygen doc (Xenomai API -> modules -> Analogy API):
http://www.xenomai.org/documentation/xenomai-2.5/html/api/index.html
- the wiki pages in the section "Device Drivers':
http://www.xenomai.org/index.php/Driver_documentation

Are you talking about these ones. Where did you see TRI_WAKE_EOS was not 
supported ?

> 
> So far I have discovered that the TRI_WAKE_EOS flags works quite ok on
> my hardware, despite being indicates as unsupported in the
> documentation. Messing with the drivers I also discovered that
> a4l_mmap() is also working. There is just a bug to iron out (I can
> provide more details on my hacking if someone is interested in helping
> my track down the issue).
> 
> At the moment I'm facing two problems:
> 
> 1. I setup an asynchronous acquisition. I then use a loop to
> a4l_sys_read() the acquired data. When the acquisition command is over,
> as configured with the .stop_src and .stop_arg in the command data
> structure, the a4l_sys_read() returns an ENOENT error. The comedi way of
> signaling the acquisition command end is to return 0, as is done for
> files to signal the end of file. I think this is an API deficiency but I
> haven't looked at how much work is to fix it.
I thought I fixed this bug a few weeks ago. I have to make a pull request.

Author: Alexis Berlemont <alexis.berlemont@domain.hid>  2010-02-06 23:00:54
Committer: Alexis Berlemont <alexis.berlemont@domain.hid>  2010-02-06 
23:55:11
Parent: 1e4f9f3524bfc8ad84f92dfba5cbfc7f07652e7f (analogy: add 
a4l_flush_sync())
Child:  527ed184265ba494c080af940b099bb537c0e9fe (analogy: reinitialize 
events flags before accepting commands)
Branches: analogy, master, remotes/origin/analogy, 
remotes/xenomai-head/master
Follows: v2.5.1
Precedes:

     analogy: read() and poll() return no more -ENOENT when acquisition 
is over


> 
> 2. Looks like it is not possible to setup an endless acquisition. If I
> set .stop_src = TRIG_NONE and .stop_arg = 0, the command submission goes
> fine, but I obtain an ENOENT error at the first a4l_sys_read(). I have
> no idea on where to look to track down this issue.
I will have a look at that soon.

> 
> Thanks. Cheers,

Alexis.

