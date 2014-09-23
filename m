Message-ID: <5421C22E.2070604@xenomai.org>
Date: Tue, 23 Sep 2014 20:55:42 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAFvTJFEsnycSeft7DEeRFXFTXb8E8xLbzFANk2HVt50ikd14gQ@mail.gmail.com>	<54206D56.7040509@xenomai.org>	<CAFvTJFGhGfuficFeDLxnDZQT=gSnmtn95933_zi16YSbD8Q9uQ@mail.gmail.com>	<54208009.5040504@xenomai.org>
 <CAFvTJFFJ=t9CXofcKhHbJVK6HnJ4-YmUt966TKXbx8MpM-zGJg@mail.gmail.com>
In-Reply-To: <CAFvTJFFJ=t9CXofcKhHbJVK6HnJ4-YmUt966TKXbx8MpM-zGJg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] kernel panic with IPIPE and LPAE on ARM OMAP5 board
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Sam Hajian <saeid.hajian@gmail.com>, xenomai@xenomai.org

On 09/23/2014 08:52 PM, Sam Hajian wrote:
> Now the issue shows up in  __ipipe_pin_range_globally where it can not
> handle kernel paging request. If try to return without doing anything
> in this code, there system will just pause and no message or kernel
> panic. Do you have any suggestion to make this code (
> __ipipe_pin_range_globally) working with 3 level page table.

I do not understand, your previous mail stated that even if you returned
in __ipipe_pin_range_globally, you had a crash?

Other than that, the only solution is to understand why it fails, and
fix it. Normally the code is already adapted to 3 levels pages, the
thing is, it has never been tested in this situation.

-- 
                                                                Gilles.

