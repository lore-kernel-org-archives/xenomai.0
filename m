Message-ID: <4AA4C7C0.9080705@domain.hid>
Date: Mon, 07 Sep 2009 10:43:44 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <1251273701.4345.9.camel@domain.hid>	 <4A94EE84.5040101@domain.hid>
	<1251354286.4321.19.camel@domain.hid>	 <4A9642D3.5040304@domain.hid>
	<1251374443.4321.40.camel@domain.hid>	 <4A978959.5060604@domain.hid>
	<1251448708.4365.11.camel@domain.hid>	 <4A979E68.1040805@domain.hid>
	<1252308904.4548.10.camel@domain.hid>
In-Reply-To: <1252308904.4548.10.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Segmentation fault in rt_printf print thread
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Christoph Permes <christoph.permes@domain.hid>
Cc: xenomai@xenomai.org

Christoph Permes wrote:
> Hi, 
> 
> I've created a patch that provides a workaround for the segmentation
> fault:
> 
> --- a/src/rtdk/rt_print.c	2009-05-21 16:34:54.000000000 +0200
> +++ b/src/rtdk/rt_print.c	2009-09-04 10:09:19.000000000 +0200
> @@ -40,6 +40,7 @@
>  struct entry_head {
>  	FILE *dest;
>  	uint32_t seq_no;
> +	uint32_t len;
>  	char text[1];
>  } __attribute__((packed));
>  
> @@ -113,6 +114,7 @@
>  			/* Write out empty entry */
>  			head = buffer->ring + write_pos;
>  			head->seq_no = __seq_no;
> +			head->len = 0;
>  			head->text[0] = 0;
>  
>  			/* Forward to the ring buffer start */
> @@ -146,6 +148,7 @@
>  	/* If we were able to write some text, finalise the entry */
>  	if (len > 0) {
>  		head->seq_no = ++__seq_no;
> +		head->len = len;
>  		head->dest = stream;
>  
>  		/* Move forward by text and head length */
> @@ -158,6 +161,7 @@
>  		/* An empty entry marks the wrap-around */
>  		head = buffer->ring + write_pos;
>  		head->seq_no = __seq_no;
> +		head->len = 0;
>  		head->text[0] = 0;
>  
>  		write_pos = 0;
> @@ -373,7 +377,7 @@
>  
>  		read_pos = buffer->read_pos;
>  		head = buffer->ring + read_pos;
> -		len = strlen(head->text);
> +		len = head->len;
>  
>  		if (len) {
>  			/* Print out non-empty entry and proceed */
> 
> With this patch I get no segfaults anymore, but of course it would be
> interesting why parts of the ring buffer are overwritten with null
> characters.
> 

Frankly, I'm suspecting some issue in your application here - at least
as long as you do not have some broken-out test case for us...

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

