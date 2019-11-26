Date: Tue, 26 Nov 2019 17:27:05 +0000
From: Jeff Webb <w1@codecraftsmen.org>
Reply-To: Jeff Webb <w1@codecraftsmen.org>
Subject: Re: [PATCH] lib/cobalt: Fix help for --print-sync-delay
Message-ID: <7TKnZNvXD85GzmpCAHRv-yZ9LE9bw9uYRZKQcpnRfHhqelMq4VdzUmEP3ViFcSr4BsVNKHBVdCQz6QFgHodqWr2Y4FJ3OsRmBvWNQKAEAis=@codecraftsmen.org>
In-Reply-To: <f4ccbc37-42d1-e683-aa26-8eadb4428470@siemens.com>
References: <f4ccbc37-42d1-e683-aa26-8eadb4428470@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>, Steve Freyder <steve@freyder.net>

On 11/16/19 2:53 AM, Jan Kiszka via Xenomai wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> Misnamed by the original commit f42334abc373.
>
> While at it, also fix indention style.
>
> Reported-by: Steve Freyder <steve@freyder.net>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>
> Seems like I missed this because it wasn't presented as patch.
> Will go to stable as well.
>
>   lib/cobalt/init.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/lib/cobalt/init.c b/lib/cobalt/init.c
> index 02a99c569c..9b506d872d 100644
> --- a/lib/cobalt/init.c
> +++ b/lib/cobalt/init.c
> @@ -353,10 +353,10 @@ static int cobalt_parse_option(int optnum, const ch=
ar *optarg)
>
>   static void cobalt_help(void)
>   {
> -        fprintf(stderr, "--main-prio=3D<prio>main thread priority\n");
> -        fprintf(stderr, "--print-buffer-size=3D<bytes>size of a print re=
lay buffer (16k)\n");
> -        fprintf(stderr, "--print-buffer-count=3D<num>number of print rel=
ay buffers (4)\n");
> -        fprintf(stderr, "--print-buffer-syncdelay=3D<ms>max delay of out=
put synchronization (100 ms)\n");
> +fprintf(stderr, "--main-prio=3D<prio>main thread priority\n");
> +fprintf(stderr, "--print-buffer-size=3D<bytes>size of a print relay buff=
er (16k)\n");
> +fprintf(stderr, "--print-buffer-count=3D<num>number of print relay buffe=
rs (4)\n");
> +fprintf(stderr, "--print-sync-delay=3D<ms>max delay of output synchroniz=
ation (100 ms)\n");
>   }
>
>   static struct setup_descriptor cobalt_interface =3D {
>

This patch fixes the issue for me.  Thanks!

-Jeff


