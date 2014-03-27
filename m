Message-ID: <53346F8A.2060008@xenomai.org>
Date: Thu, 27 Mar 2014 19:35:54 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <53316C4C.6000708@sigmatek.at>	<CANKLDmuMDpiUC7Z7dsXa5K3LYNA4LNwA7mhAicJ_Dey+2S9PCg@mail.gmail.com>	<53335D9A.9040902@xenomai.org>	<5333F22F.70805@xenomai.org>
 <CANKLDmttO4jZtRxV-bjYQwg3YkGBKwFL74ATkdM2SBH8Xby31A@mail.gmail.com>
 <53345143.7000009@xenomai.org> <53346835.4030202@web.de>
 <53346CF7.2020805@xenomai.org>
In-Reply-To: <53346CF7.2020805@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Rescnt imbalance in rtdm_mutex_timedlock
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@web.de>, "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 03/27/2014 07:24 PM, Philippe Gerum wrote:
> I'm unsure we really need to take a chance at giving such hint. Modern
> CPUs tend to have branch prediction right.

Not to mention the fact that the compiler may not use the information 
used by likely/unlikely, or may not be able use it in a sensible way.

Typically, for code such as

if (unlikely(condition))
	return 0;

I do not see that it makes sense for the compiler to "jump out of hot 
path", for a return 0, it will put the return 0 in place, there is 
nothing to win by jumping away to then just return.

-- 
					    Gilles.

