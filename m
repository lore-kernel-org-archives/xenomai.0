From: Christoph Permes <christoph.permes@domain.hid>
In-Reply-To: <4A979E68.1040805@domain.hid>
References: <1251273701.4345.9.camel@domain.hid>
	<4A94EE84.5040101@domain.hid> <1251354286.4321.19.camel@domain.hid>
	<4A9642D3.5040304@domain.hid> <1251374443.4321.40.camel@domain.hid>
	<4A978959.5060604@domain.hid> <1251448708.4365.11.camel@domain.hid>
	<4A979E68.1040805@domain.hid>
Date: Mon, 31 Aug 2009 10:09:56 +0200
Message-Id: <1251706196.4308.32.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
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
Cc: xenomai@xenomai.org

Am Freitag, den 28.08.2009, 11:07 +0200 schrieb Jan Kiszka:
> Christoph Permes wrote:
> 
> Untested stuff as I should already be on the road. Here is another try,
> but please don't expect replies from me over this weekend.
> 
> Jan
> 
> diff --git a/src/rtdk/rt_print.c b/src/rtdk/rt_print.c
> index 0615247..06dabc1 100644
> --- a/src/rtdk/rt_print.c
> +++ b/src/rtdk/rt_print.c
> @@ -16,6 +16,7 @@
>   * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
>   */
>  
> +#include <assert.h>
>  #include <errno.h>
>  #include <inttypes.h>
>  #include <limits.h>
> @@ -37,7 +38,10 @@
>  
>  #define RT_PRINT_LINE_BREAK		256
>  
> +#define RT_PRINT_HEAD_MAGIC		0xDEADBEAF
> +
>  struct entry_head {
> +	uint32_t magic;
>  	FILE *dest;
>  	uint32_t seq_no;
>  	char text[1];
> @@ -103,6 +107,10 @@ int rt_vfprintf(FILE *stream, const char *format, va_list args)
>  	read_pos = buffer->read_pos;
>  	xnarch_read_memory_barrier();
>  
> +	assert(write_pos == read_pos ||
> +	       ((struct entry_head *)buffer->ring + buffer->read_pos)->magic ==
> +	       RT_PRINT_HEAD_MAGIC);
> +
>  	/* Is our write limit the end of the ring buffer? */
>  	if (write_pos >= read_pos) {
>  		/* Keep a savety margin to the end for at least an empty entry */
> @@ -114,6 +122,7 @@ int rt_vfprintf(FILE *stream, const char *format, va_list args)
>  		if (len == 0 && read_pos > sizeof(struct entry_head)) {
>  			/* Write out empty entry */
>  			head = buffer->ring + write_pos;
> +			head->magic = RT_PRINT_HEAD_MAGIC;
>  			head->seq_no = seq_no;
>  			head->text[0] = 0;
>  
> @@ -136,6 +145,10 @@ int rt_vfprintf(FILE *stream, const char *format, va_list args)
>  
>  	res = vsnprintf(head->text, len, format, args);
>  
> +	assert(write_pos == read_pos ||
> +	       ((struct entry_head *)buffer->ring + buffer->read_pos)->magic ==
> +	       RT_PRINT_HEAD_MAGIC);
> +
>  	if (res < len) {
>  		/* Text was written completely, res contains its length */
>  		len = res;
> @@ -147,6 +160,7 @@ int rt_vfprintf(FILE *stream, const char *format, va_list args)
>  
>  	/* If we were able to write some text, finalise the entry */
>  	if (len > 0) {
> +		head->magic = RT_PRINT_HEAD_MAGIC;
>  		head->seq_no = ++seq_no;
>  		head->dest = stream;
>  
> @@ -159,6 +173,7 @@ int rt_vfprintf(FILE *stream, const char *format, va_list args)
>  	    read_pos <= write_pos && read_pos > buffer->size - write_pos) {
>  		/* An empty entry marks the wrap-around */
>  		head = buffer->ring + write_pos;
> +		head->magic = RT_PRINT_HEAD_MAGIC;
>  		head->seq_no = seq_no;
>  		head->text[0] = 0;
>  
> @@ -382,6 +397,8 @@ static void print_buffers(void)
>  		head = buffer->ring + read_pos;
>  		len = strlen(head->text);
>  
> +		assert(head->magic == RT_PRINT_HEAD_MAGIC);
> +
>  		if (len) {
>  			/* Print out non-empty entry and proceed */
>  			fprintf(head->dest, "%s", head->text);
> 

I ran some tests over the weekend and got two more crashs. In both cases
the assert statement in print_buffers() failed.

After taking a closer look on the core file from last week and the new
ones I found out that parts of the printed text were overwritten with
one or more zero characters.
As a result the strlen() statement in print_buffers() does not return
the complete text length and the next try to read data from the buffer
fails as the read position is not correct anymore.

As a first workaround I will try to store the length returned by
vsnprintf() in the entry_head struct and use this value for incrementing
the read position to avoid the SEGV.

Christoph




