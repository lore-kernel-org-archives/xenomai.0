Message-ID: <4DB17F63.2050504@domain.hid>
Date: Fri, 22 Apr 2011 15:15:15 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <BANLkTimmraMpqpZ2areb0z9aC2U19SE5_w@domain.hid>	<4DB143E8.3000900@domain.hid>
	<BANLkTikNWeDdRMXFN=gHK=sQshMgP-=y5w@domain.hid>
In-Reply-To: <BANLkTikNWeDdRMXFN=gHK=sQshMgP-=y5w@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] first module help
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Aurele Traynard <aurele.traynard@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Aurele Traynard wrote:
> ok i'm sorry i wasn't clear at all...
> my problem is : when i call readl in a rt_task, the task is stopped...
> (maybe because the rt_task is launched in a module?)
> "Xenomai: suspending kernel thread bf0041c8 ('test_rt') at 0xbf003824 after
> exception #0"
> if i remove the readl there is no problem
> 
> With a normal Linux, in a module there isn't any problem

On what platform? I can think of two things:
- the platform you use maps the ioremaped memory on-demand (x86 and ARM
at least do not allow this, but I do not know about other platforms)
- you are making an unaligned access, it works with Linux because it has
a handler for handling unaligned accesses, whereas Xenomai default
handler is to simply suspend a task doing this kind of things.

Please do not forget to CC the mailing list.

-- 
					    Gilles.

