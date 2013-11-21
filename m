Message-ID: <528E74AF.8080404@xenomai.org>
Date: Thu, 21 Nov 2013 22:01:35 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <1385063104.21818.YahooMailNeo@web193606.mail.sg3.yahoo.com>
In-Reply-To: <1385063104.21818.YahooMailNeo@web193606.mail.sg3.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] rt_task_set_periodic
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Alex Martin <alex.martin92@ymail.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 11/21/2013 08:45 PM, Alex Martin wrote:
> Hi,
>
> I want to adjust the period set for rt_task_set_periodic.
>
> It is required to adjust the period value at run time when task is running.
> I want to adjust the task period to external clock.
>
> period will about 5 milli seconds.( I set it to 5e6 ). There will be always difference between two clocks. I want to adjust dynamically during run time period of the xenomai task to match external clock.
>
> Which function can be used.
>

Simply issue rt_task_set_periodic again, with the adjusted period.

> Best regards,
>
> Alex.
>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai
>


-- 
Philippe.

