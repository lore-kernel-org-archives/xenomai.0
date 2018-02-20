References: <b709f916-7c1e-8adb-bae7-60ce388fc8fc@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <5c284b6e-b5e4-0054-805e-af4f7c15ee04@xenomai.org>
Date: Tue, 20 Feb 2018 10:26:20 +0100
MIME-Version: 1.0
In-Reply-To: <b709f916-7c1e-8adb-bae7-60ce388fc8fc@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] lib/boilerplate: Prevent migration to
 secondary mode for __printout
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>
Cc: "Hartmann, Wolfgang" <wolfgang.hartmann@siemens.com>

On 02/09/2018 05:54 PM, Jan Kiszka wrote:
> From: Wolfgang Hartmann <wolfgang.hartmann@siemens.com>
> 
> Use the __RT versions of the stdio function calls to avoid migration to
> secondary mode. In case of ___panic, flush the printer before exiting to
> avoid losing messages.
> 
> Signed-off-by: Wolfgang Hartmann <wolfgang.hartmann@siemens.com>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  lib/boilerplate/ancillaries.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/lib/boilerplate/ancillaries.c b/lib/boilerplate/ancillaries.c
> index 13d7fafa4..225e44995 100644
> --- a/lib/boilerplate/ancillaries.c
> +++ b/lib/boilerplate/ancillaries.c
> @@ -52,15 +52,14 @@ static void __do_printout(const char *name, const char *header,
>  {
>  	FILE *fp = stderr;
>  
> -	fprintf(fp, "%4u\"%.3u.%.3u| ", ms / 1000, ms % 1000, us);
> +	__RT(fprintf(fp, "%4u\"%.3u.%.3u| ", ms / 1000, ms % 1000, us));
>  
>  	if (header)
> -		fputs(header, fp);
> +		__RT(fputs(header, fp));
>  
> -	fprintf(fp, "[%s] ", name ?: "main");
> -	vfprintf(fp, fmt, ap);
> -	fputc('\n', fp);
> -	fflush(fp);
> +	__RT(fprintf(fp, "[%s] ", name ?: "main"));
> +	__RT(vfprintf(fp, fmt, ap));
> +	__RT(fputc('\n', fp));
>  }
>  
This would not work as intended during the early init phase. We may not invoke any wrapped call until init_done is set by __boilerplate_init(). In addition to the above patch, you would also need something like:

diff --git a/lib/boilerplate/ancillaries.c b/lib/boilerplate/ancillaries.c
index 13d7fafa4..f2c3b329f 100644
--- a/lib/boilerplate/ancillaries.c
+++ b/lib/boilerplate/ancillaries.c
@@ -46,6 +46,13 @@ static struct timespec init_date;
 
 static int init_done;
 
+static void __do_early_printout(const char *name, const char *header,
+				unsigned int ms, unsigned int us,
+				const char *fmt, va_list ap)
+{
+	/* ... should use __STD() POSIX calls only ... */
+}
+
 static void __do_printout(const char *name, const char *header,
 			  unsigned int ms, unsigned int us,
 			  const char *fmt, va_list ap)
@@ -77,7 +84,7 @@ void __printout(const char *name, const char *header,
 	 * uncontended.
 	 */
 	if (!init_done) {
-		__do_printout(name, header, 0, 0, fmt, ap);
+		__do_early_printout(name, header, 0, 0, fmt, ap);
 		return;
 	}
 	

-- 
Philippe.

