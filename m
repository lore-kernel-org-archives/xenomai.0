Message-ID: <530F0A90.4090605@xenomai.org>
Date: Thu, 27 Feb 2014 10:51:12 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <530F08DC.3040902@sigmatek.at>
In-Reply-To: <530F08DC.3040902@sigmatek.at>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] priority inheritance question
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: johann.obermayr@sigmatek.at, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 02/27/2014 10:43 AM, Johann Obermayr wrote:
> Hello,
>
> have 2 tasks
> task1 with prio 10
> task2 with prio 20
>
> task1 acquire a mutex
> now task2 will acquire the same mutex
>
> than task1 get higher priority.
>
> But what gets priority task1?
> 20 or 21 ?
>

20.

-- 
Philippe.

