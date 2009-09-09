Message-ID: <4AA7986B.8000704@domain.hid>
Date: Wed, 09 Sep 2009 13:58:35 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1251273701.4345.9.camel@domain.hid>		<4A94EE84.5040101@domain.hid>	<1251354286.4321.19.camel@domain.hid>		<4A9642D3.5040304@domain.hid>	<1251374443.4321.40.camel@domain.hid>		<4A978959.5060604@domain.hid>	<1251448708.4365.11.camel@domain.hid>		<4A979E68.1040805@domain.hid>	<1252308904.4548.10.camel@domain.hid>	<4AA4C7C0.9080705@domain.hid>
	<4AA4CB3A.8030703@domain.hid>	<4AA4CFA5.60907@domain.hid>
	<4AA794B5.3080403@domain.hid>
In-Reply-To: <4AA794B5.3080403@domain.hid>
Content-Type: multipart/mixed; boundary="------------020904010805040108080501"
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------020904010805040108080501
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>> Jan Kiszka wrote:
>>>> Christoph Permes wrote:
>>>>> Hi, 
>>>>>
>>>>> I've created a patch that provides a workaround for the segmentation
>>>>> fault:
>>>>>
>>>>> --- a/src/rtdk/rt_print.c	2009-05-21 16:34:54.000000000 +0200
>>>>> +++ b/src/rtdk/rt_print.c	2009-09-04 10:09:19.000000000 +0200
>>>>> @@ -40,6 +40,7 @@
>>>>>  struct entry_head {
>>>>>  	FILE *dest;
>>>>>  	uint32_t seq_no;
>>>>> +	uint32_t len;
>>>>>  	char text[1];
>>>>>  } __attribute__((packed));
>>>>>  
>>>>> @@ -113,6 +114,7 @@
>>>>>  			/* Write out empty entry */
>>>>>  			head = buffer->ring + write_pos;
>>>>>  			head->seq_no = __seq_no;
>>>>> +			head->len = 0;
>>>>>  			head->text[0] = 0;
>>>>>  
>>>>>  			/* Forward to the ring buffer start */
>>>>> @@ -146,6 +148,7 @@
>>>>>  	/* If we were able to write some text, finalise the entry */
>>>>>  	if (len > 0) {
>>>>>  		head->seq_no = ++__seq_no;
>>>>> +		head->len = len;
>>>>>  		head->dest = stream;
>>>>>  
>>>>>  		/* Move forward by text and head length */
>>>>> @@ -158,6 +161,7 @@
>>>>>  		/* An empty entry marks the wrap-around */
>>>>>  		head = buffer->ring + write_pos;
>>>>>  		head->seq_no = __seq_no;
>>>>> +		head->len = 0;
>>>>>  		head->text[0] = 0;
>>>>>  
>>>>>  		write_pos = 0;
>>>>> @@ -373,7 +377,7 @@
>>>>>  
>>>>>  		read_pos = buffer->read_pos;
>>>>>  		head = buffer->ring + read_pos;
>>>>> -		len = strlen(head->text);
>>>>> +		len = head->len;
>>>>>  
>>>>>  		if (len) {
>>>>>  			/* Print out non-empty entry and proceed */
>>>>>
>>>>> With this patch I get no segfaults anymore, but of course it would be
>>>>> interesting why parts of the ring buffer are overwritten with null
>>>>> characters.
>>>>>
>>>> Frankly, I'm suspecting some issue in your application here - at least
>>>> as long as you do not have some broken-out test case for us...
>>> Would not it be possible to mprotect the rtdk buffer when it is not used
>>> in order to catch any write to it outside of rtdk functions?
>>>
>> Hmm, good idea, should work. Once set up, only rt_vsnprintf requires
>> write access to the ring.
> 
> Ok. Here it comes. Note however that calling rt_printf with this patch
> will cause the caller to switch to secondary mode, but that is OK for
> debugging. Also note that I only compile-tested the patch.

Except that the first mprotect should go before the read barrier. So, a
better version.

-- 
                                          Gilles


--------------020904010805040108080501
Content-Type: text/x-patch;
 name="xeno-rtdk-mprotect.2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xeno-rtdk-mprotect.2.diff"

diff --git a/src/rtdk/rt_print.c b/src/rtdk/rt_print.c
index 0615247..fd752d1 100644
--- a/src/rtdk/rt_print.c
+++ b/src/rtdk/rt_print.c
@@ -101,6 +101,7 @@ int rt_vfprintf(FILE *stream, const char *format, va_list args)
 	/* Take a snapshot of the ring buffer state */
 	write_pos = buffer->write_pos;
 	read_pos = buffer->read_pos;
+	mprotect(buffer->ring, buffer->size, PROT_READ | PROT_WRITE);
 	xnarch_read_memory_barrier();
 
 	/* Is our write limit the end of the ring buffer? */
@@ -167,6 +168,7 @@ int rt_vfprintf(FILE *stream, const char *format, va_list args)
 
 	/* All entry data must be written before we can update write_pos */
 	xnarch_write_memory_barrier();
+	mprotect(buffer->ring, buffer->size, PROT_READ);
 
 	buffer->write_pos = write_pos;
 
@@ -223,6 +225,7 @@ int rt_print_init(size_t buffer_size, const char *buffer_name)
 		size = default_buffer_size;
 	else if (size < RT_PRINT_LINE_BREAK)
 		return EINVAL;
+	size = (size + getpagesize() - 1) & ~(getpagesize() - 1);
 
 	if (buffer) {
 		/* Only set name if buffer size is unchanged or default */
@@ -237,12 +240,11 @@ int rt_print_init(size_t buffer_size, const char *buffer_name)
 	if (!buffer)
 		return ENOMEM;
 
-	buffer->ring = malloc(size);
+	buffer->ring = mmap(NULL, size, PROT_READ, MAP_ANONYMOUS | MAP_PRIVATE,  -1, 0);
 	if (!buffer->ring) {
 		free(buffer);
 		return ENOMEM;
 	}
-	memset(buffer->ring, 0, size);
 
 	buffer->read_pos  = 0;
 	buffer->write_pos = 0;

--------------020904010805040108080501--

