Message-ID: <434E6E18.8000603@domain.hid>
Date: Thu, 13 Oct 2005 16:24:24 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] A couple of questions
References: <18969.193.52.24.125.1129211788.squirrel@domain.hid>
In-Reply-To: <18969.193.52.24.125.1129211788.squirrel@domain.hid>
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
To: smannori@domain.hid
Cc: xenomai@xenomai.org, Alexis Berlemont <alexis.berlemont@domain.hid>

smannori@domain.hid wrote:
> Hi everybody:
> 
> I think that this fork is a very good opportunity to "start with the
> right foot". I believe also that a document like

Well, technically it's a split, not a fork; i.e. you don't fork your own code 
out of yourself. The RTAI 3.x and RTAI/fusion codebases have always been 
separate, basically because they can't mix properly at core level and pursue 
different goals. Hence the split.

> 
> https://mail.rtai.org/pipermail/rtai/2005-June/011949.html
> 
> but with Fusion/Xenomai it would be a very good starting point for a
> relatively inexperienced user. What I do until now:
> - I dowloaded, adeos-patched, configured & compiled kernel 2.6.13.4
> - I downloaded, configured, installed fusion 0.9.1
> - I run sucessfull all the [testsuite] examples
> - I dowloaded all the pdf(s)
> 
> Now the questions:
> 1) it is important dowload and install fusion OR xenomai ?

Xenomai. RTAI/fusion is dead; all fusion contributors moved to Xenomai.

> 2)  why the xenomai files are so old (2002) ?

Which ones? Those under the attic/ directory? Well, because Xenomai has been 
founded in 2001, and what you see there are the versions released up to 1.1.1, 
before the project had decided to merge with RTAI in 2003, in order to  produce 
a pervasive and highly integrated real-time framework for the GNU/Linux 
environment, based on the initial Xenomai codebase.

What we have done is basically a retro-merge, getting back our independence so 
that we can continue the development effort in a more consistent manner. The 
next version based on the latest CVS tree from RTAI/fusion 0.9.1 with additional 
updates will then be 2.0. For the time being, only our development tree 
(http://gna.org/svn/?group=xenomai) is available since there has been no formal 
release of "Xenomai reloaded" yet.

> 3) I think that a very important PDF file - already present in the past
> in www.rtai.org - is missed: the Fusion tutorial with examples.

They have been restored there.
http://download.gna.org/xenomai/documentation/

They will be referenced by our new website as soon as it is available.

> 4) where I can find some Fusion/Xenomai examples, complete of instruction
> to compile and link to create standalone applications ?

Look at the demos/ directories under the various skins. Some of the PDF 
documents available from the URL above give more.

> 5) how is it possible to use Comedi driver ?

Alex did a port of Comedi over RTAI/fusion. It will need to be rejuvenated over 
Xenomai.

> 6) how port xrtailab under Xenomai/Fusion ?

Don't know. But if you do know xrtailab enough, you should have more clues than 
I do regarding the port though.

> 7) it is possible use USB device (eg. camera) realtime ?
> 

AFAIK, a generic effort has been started:
http://developer.berlios.de/projects/usb4rt

-- 

Philippe.

