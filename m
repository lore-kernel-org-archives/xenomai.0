Date: Sun, 30 Aug 2015 15:10:52 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150830131052.GI20679@hermes.click-hack.org>
References: <414081485.3401651.1440938075099.JavaMail.yahoo@mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <414081485.3401651.1440938075099.JavaMail.yahoo@mail.yahoo.com>
Subject: Re: [Xenomai] xenomai on debian
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?utf-8?B?4oCrTW9oYW1lZCBGYXd6eeKArCDigKs=?= <m.fawzy307@yahoo.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Sun, Aug 30, 2015 at 12:34:35PM +0000, ‫Mohamed Fawzy‬ ‫ wrote:
> i followed these instructions to install xenomai 2.6.0 on debian wheezy 
> http://xenomai.org/2014/06/building-debian-packages/
> but when i built the packages using (debuild -uc -us )i got this messge and build failed 
> 
> 
> {standard input}: Assembler messages:{standard input}:144: Error: thumb conditional instruction should be in IT block -- `strexeq r0,r1,[r3]'{standard input}:538: Error: thumb conditional instruction should be in IT block -- `strexeq r5,r4,[r3]'
> 
> what's the wrong with me ? 

As usual, you do not give us enough information. What I-pipe patch
are you using? You get this error when compiling which file? What
version of gcc are you using?

IOW: please read:
https://xenomai.org//asking-for-help/

-- 
					    Gilles.
https://click-hack.org

