Subject: Re: domain switch
References: <CAFZ-hKjeJZGD7s54hH_QURdY4z=ViUEz3_mrgQbwH4pX4weY+g@mail.gmail.com>
From: steve freyder <steve@freyder.net>
Message-ID: <fa5f0b2a-4f92-343c-b00d-0d75ee79a97e@freyder.net>
Date: Sat, 2 Jan 2021 17:06:21 -0600
MIME-Version: 1.0
In-Reply-To: <CAFZ-hKjeJZGD7s54hH_QURdY4z=ViUEz3_mrgQbwH4pX4weY+g@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Leandro Bucci <guestleandro11@gmail.com>, xenomai@xenomai.org

Right.


AKA, "mode switch", a switch from "primary mode" to "secondary mode", or 
vice versa.

One place you can find that information is in:

/proc/xenomai/sched/acct

there are two fields MSW, and CSW which count mode/context switches 
per-process. This requires an open, a read loop to locate the desired 
pid and extract the desired information, then either rewind or 
close/reopen to do it again - all of which will almost surely generate 
more mode/context switching.


On 1/2/2021 2:54 PM, Leandro Bucci via Xenomai wrote:
> Hi, I wanted to know if there was a way to count the number of times a
> domain switch happens.
> For example the printf () function causes a domain switch, right?
