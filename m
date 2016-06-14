References: <5734A9F8.10305@siemens.com>
 <20160512163142.GC18298@hermes.click-hack.org> <5734B43B.4040001@siemens.com>
 <20160512165904.GF18298@hermes.click-hack.org>
 <20160512171246.GG18298@hermes.click-hack.org> <5734BA9B.1030503@siemens.com>
 <20160512182049.GQ13285@hermes.click-hack.org> <5734CA76.5000606@siemens.com>
 <5734CCF8.5090508@xenomai.org> <5734CE80.60707@siemens.com>
 <5734D4B9.4070900@xenomai.org> <5734D92F.1000206@siemens.com>
 <57350331.1020302@xenomai.org> <57356C0E.6080205@siemens.com>
 <5735D8E0.3040202@xenomai.org> <5735F39A.8050204@siemens.com>
 <57601E35.3010101@siemens.com>
 <5a98b862-5b1f-449c-8989-f7e3d4fe8255@xenomai.org>
 <5760227A.3010203@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <5760271A.4020204@siemens.com>
Date: Tue, 14 Jun 2016 17:47:38 +0200
MIME-Version: 1.0
In-Reply-To: <5760227A.3010203@siemens.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] RTDM syscalls & switching
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 2016-06-14 17:27, Jan Kiszka wrote:
> BTW, we is corectl a probing syscall? It doesn't make use of this
> feature at all.

Oh, there is - oversaw one code path in do_conf_option.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux

