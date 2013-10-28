Message-ID: <526E67F4.5090707@xenomai.org>
Date: Mon, 28 Oct 2013 14:34:44 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAKKWdtfD3ZQOR9pVK1fG_z2fdxZziknh6p99OxCTWwLtZN45pw@mail.gmail.com>
In-Reply-To: <CAKKWdtfD3ZQOR9pVK1fG_z2fdxZziknh6p99OxCTWwLtZN45pw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] questions about scheduling
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: ali hagigat <hagigatali@gmail.com>
Cc: xenomai <xenomai@xenomai.org>

On 10/28/2013 02:07 PM, ali hagigat wrote:
> when rt_alarm_wait() is called the priority rises. so what is that
> priority? is it between 1 to 99?
> that priority is boosted only once and temporarily when the waiting
> process is executed right after wait()?
> or the base priority of that process changes afterwards?
> 
see:

http://www.xenomai.org/documentation/xenomai-2.6/html/api/group__alarm.html#ga6c0caadae03541db8a46751d290c0d76
-- 
					    Gilles.

