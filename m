Message-ID: <525ACECC.5030300@xenomai.org>
Date: Sun, 13 Oct 2013 18:48:12 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <3426cfa7bb3a21b9b4cb.1381471566@devws164.be.alcatel-lucent.com>
In-Reply-To: <3426cfa7bb3a21b9b4cb.1381471566@devws164.be.alcatel-lucent.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] Xenomai-forge pSOS task: Allow event send to
 self (current task)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Kim De Mey <kim.demey@gmail.com>, xenomai@xenomai.org

On 10/11/2013 08:06 AM, Kim De Mey wrote:
> Support 0 as value for the tid parameter in ev_send.
> This then sends the event to the current task.
>
> Signed-off-by: Kim De Mey <kim.demey@gmail.com>
>
> ---
> Hello,
>
> I believe this is existing functionality in Xenomai.
> Would it be possible to add this in Xenomai-forge?
>

Merged, thanks.

-- 
Philippe.

