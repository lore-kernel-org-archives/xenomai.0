Message-ID: <4FCCC307.4050803@xenomai.org>
Date: Mon, 04 Jun 2012 16:15:35 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4FCCB885.60802@gmail.com>
In-Reply-To: <4FCCB885.60802@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] question on host tick processing
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: abhri <abhri.datta@gmail.com>
Cc: xenomai@xenomai.org

On 06/04/2012 03:30 PM, abhri wrote:
> Hi,
> I have a doubt regarding host tick propagation. I understand that host 
> tick will be relayed when XNHTICK bit is set and there is a domain 
> migration to root. In case there is large delay to change domain from 
> primary to secondary how is the host tick corrected when relayed next. 

If this happens, then there is a problem in your application. Part of
the things required of your application when writing an application for
a dual-kernel solution is to let the other kernel run from time to time.

> Is there any correction mechanism in nucleus for keeping linux time correct?

AFAIK, there is one in the linux kernel itself. The linux kernel uses
separate objects (clocksource and clockevents) for hardware clocks and
timers.

-- 
					    Gilles.

