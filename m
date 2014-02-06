Message-ID: <52F3B9D2.9070205@xenomai.org>
Date: Thu, 06 Feb 2014 17:35:30 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <52F3B77F.3020405@marel.com>
In-Reply-To: <52F3B77F.3020405@marel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] High CPU load using q_send under pSOS skin
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Marcel van Mierlo <marcel.vanmierlo@marel.com>
Cc: xenomai@xenomai.org

On 02/06/2014 05:25 PM, Marcel van Mierlo wrote:
> Hi,
>
> I've been investigating this for a couple of days and would really
> appreciate some insight
> on what might be going on or what I can do to progress this...
>
> I am porting a legacy pSOS application - to Xenomai on BeagleBoard Black
> 3.8 kernel
> and have noticed %CPU (via. top) of MAIN around 40% when using q_send,
> and doing no "work".
>
> Surprisingly,  if I add a printf() and fflush() to the task body then
> the CPU drops down to < 1%.
>
> I've checked compile options, nothing obviously wrong. Here is the
> (abridged) body of the task.
> It just provides a periodic message for watchdog purposes.
>
>
> [%CPU ~%40]
> while{1}
> {
>       q_send(ulCanTQid, (INT32 *)&oCanMsg);
>       tm_wkafter(100);  // ~100ms

Have you checked that the comment is right? Are you sure you are not 
sleeping 100ns ?

-- 
					    Gilles.

