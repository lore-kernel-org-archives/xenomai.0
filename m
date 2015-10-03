References: <CAKO1R-ReR8XT8n6_UHWCV=vnk_Y38QkSiSjf0_HVg0=Eu70VNg@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <560FA3DF.1030204@xenomai.org>
Date: Sat, 3 Oct 2015 11:46:07 +0200
MIME-Version: 1.0
In-Reply-To: <CAKO1R-ReR8XT8n6_UHWCV=vnk_Y38QkSiSjf0_HVg0=Eu70VNg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Cyclictest in Xenomai-3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?5p6X5bGV57+U?= <chlin6016@gmail.com>, xenomai@xenomai.org

On 10/03/2015 11:35 AM, 林展翔 wrote:
> Hello,
> 
> I've cloned the code from Konstantinos's github page and amended the
> Makefile and cyclictest.c like Philippe had suggested.
> 
> But when I ran cyclictest(after compilation) with the command './cyclictest
> -p 99 -i 250 -n', the MAX latency was still over 200us.
> 
> Can anyone tell me where the problem might be?

A good way to check whether you actually fixed up the original code
properly with the earlier, out of tree cyclictest, is to run Xenomai's
latency test. Not seeing any latency issues with that one would give you
some hint about where the problem might be.

-- 
Philippe.

