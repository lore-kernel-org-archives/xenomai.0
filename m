Date: Thu, 19 Nov 2015 12:57:31 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151119115731.GA16710@hermes.click-hack.org>
References: <2396B4D2166B62479FBBE370D4A7C1F30A70D64A@mb2010-1.intra.tut.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2396B4D2166B62479FBBE370D4A7C1F30A70D64A@mb2010-1.intra.tut.fi>
Subject: Re: [Xenomai] Problem: rtifconfig rteth0 hangs the terminal and
 applications except mouse cursor.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Umair Ali <ali.umair@tut.fi>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Thu, Nov 19, 2015 at 11:44:50AM +0000, Umair Ali wrote:
> Can you tell me what is causing the problem.

Definitely not. See:
http://xenomai.org/asking-for-help/

The first thing to do, to see the error messages is to run in text
mode and not graphic mode, or to redirect the kernel console to a
serial port.

You should also check that you do not have irq conflicts, see:
http://xenomai.org/2014/06/what-if-xenomai-and-linux-devices-share-the-same-irq/

-- 
					    Gilles.
https://click-hack.org

