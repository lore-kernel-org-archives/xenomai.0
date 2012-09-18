Message-ID: <5058D81A.9070305@xenomai.org>
Date: Tue, 18 Sep 2012 22:22:50 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5053404B.9000006@iit.it> <50537A5F.5030301@xenomai.org>
In-Reply-To: <50537A5F.5030301@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] segfault using rt_printf service
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Alessio Margan @ IIT" <alessio.margan@iit.it>
Cc: xenomai <xenomai@xenomai.org>

On 09/14/2012 08:41 PM, Gilles Chanteperdrix wrote:

> On 09/14/2012 04:33 PM, Alessio Margan @ IIT wrote:
> 
>> Hi all,
>>
>> I'm switching from xenomai 2.5.6 to 2.6.1 using 
>> adeos-ipipe-2.6.38.8-x86-2.11-01.patch
>> In this test I have 2 threads :
>> - rx_udp receive udp packets from dsp boards at 1kHz
>> - boards_test send udp packets at 1kHz
>>
>> I got segfault in printer_loop thread, the point is that if I change env 
>> var RT_PRINT_PERIOD to about 10 or 1000 (default is 100 ms) I do not 
>> have segfault.
>>
>> Any suggestion ?
> 
> 
> Could you try the following patch?
> 
> diff --git a/src/skins/common/rt_print.c b/src/skins/common/rt_print.c
> index a9fce78..376330b 100644
> --- a/src/skins/common/rt_print.c
> +++ b/src/skins/common/rt_print.c
> @@ -163,9 +163,9 @@ static int vprint_to_buffer(FILE *stream, int priority, unsigned int mode,
>  	if (mode == RT_PRINT_MODE_FORMAT) {
>  		if (stream != RT_PRINT_SYSLOG_STREAM) {
>  			/* We do not need the terminating \0 */
> -			res = vsnprintf(head->data, len + 1, format, args);
> +			res = vsnprintf(head->data, len, format, args);
>  
> -			if (res < len + 1) {
> +			if (res < len) {
>  				/* Text was written completely, res contains its
>  				   length */
>  				len = res;
> 
> 


ping ?

-- 
                                                                Gilles.

