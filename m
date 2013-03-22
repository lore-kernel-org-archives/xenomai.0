Message-ID: <514C9E86.7020701@xenomai.org>
Date: Fri, 22 Mar 2013 19:10:14 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <e21b6c3989fe9c98508a.1363359173@devws108>
In-Reply-To: <e21b6c3989fe9c98508a.1363359173@devws108>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] psos skin: time_slice is specified in ticks
 instead of ns
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ronny Meeus <ronny.meeus@gmail.com>
Cc: xenomai@xenomai.org

On 03/15/2013 03:52 PM, Ronny Meeus wrote:
> The pSOS skin uses a default timeslice of 1000 sec.
> In comments it is mentioned that the value is specified in ms
> while the place where the variable is used assumes that it is
> in ticks.
>
> Rename time_slice to time_slice_in_ticks to make this clear.
> Additionally, increase the timeslice from the intended 1ms
> to 5ms to reduce the overhead a bit.
>
> Signed-off-by: Ronny Meeus <ronny.meeus@gmail.com>

Merged to the staging branch, on its way to mainline, thanks.

http://git.xenomai.org/?p=xenomai-forge.git;a=commit;h=eaef61542ff3ec37d40de84361d69ec309840d0a

-- 
Philippe.

