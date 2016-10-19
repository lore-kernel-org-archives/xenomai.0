Sender: Michael Welling <mwelling79@gmail.com>
Date: Wed, 19 Oct 2016 15:48:57 -0500
From: Michael Welling <mwelling@ieee.org>
Message-ID: <20161019204857.GA8539@deathstar>
References: <1456186926-2517-1-git-send-email-mwelling@ieee.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1456186926-2517-1-git-send-email-mwelling@ieee.org>
Subject: Re: [Xenomai] [PATCH v2] demo/alchemy/cross-link: Properly handle
 syscall errors
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, Jan Kiszka <jan.kiszka@siemens.com>, Lowell Gilbert <kludge@be-well.ilk.org>

Anything blocking this blocking from being submitted?
ACKs, NAKs, reviews?

On Mon, Feb 22, 2016 at 06:22:06PM -0600, Michael Welling wrote:
> Update cross link demo to properly handle errors returned from syscalls.
> 
> Signed-off-by: Michael Welling <mwelling@ieee.org>
> ---
> v2: Fixes up error handling it close_file.
> Makes sure error is properly returned in main.
> 
>  demo/alchemy/cobalt/cross-link.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/demo/alchemy/cobalt/cross-link.c b/demo/alchemy/cobalt/cross-link.c
> index 8c0f53f..0dbd415 100644
> --- a/demo/alchemy/cobalt/cross-link.c
> +++ b/demo/alchemy/cobalt/cross-link.c
> @@ -78,6 +78,7 @@ static int close_file( int fd, char *name)
>  	do {
>  		i++;
>  		err = close(fd);
> +		err = err < 0 ? -errno : 0;
>  		switch (err) {
>  		case -EAGAIN:
>  			printf(MAIN_PREFIX "%s -> EAGAIN (%d times)\n",
> @@ -158,7 +159,7 @@ static void write_task_proc(void *arg)
>  		written = write(write_fd, &write_time, sz);
>  		if (written < 0 ) {
>  			printf(WTASK_PREFIX "error on write, %s\n",
> -			       strerror(-err));
> +			       strerror(errno));
>  			break;
>  		} else if (written != sz) {
>  			printf(WTASK_PREFIX "only %d / %zd byte transmitted\n",
> @@ -199,6 +200,7 @@ static void read_task_proc(void *arg)
>  		/* waiting for event */
>  		err = ioctl(read_fd, RTSER_RTIOC_WAIT_EVENT, &rx_event);
>  		if (err) {
> +			err = -errno;
>  			printf(RTASK_PREFIX
>  			       "error on RTSER_RTIOC_WAIT_EVENT, %s\n",
>  			       strerror(-err));
> @@ -218,7 +220,7 @@ static void read_task_proc(void *arg)
>  			nr++;
>  		} else if (rd < 0 ) {
>  			printf(RTASK_PREFIX "error on read, code %s\n",
> -			       strerror(-err));
> +			       strerror(errno));
>  			break;
>  		} else {
>  			printf(RTASK_PREFIX "only %d / %zd byte received \n",
> @@ -244,8 +246,9 @@ int main(int argc, char* argv[])
>  	/* open rtser0 */
>  	write_fd = open( WRITE_FILE, 0);
>  	if (write_fd < 0) {
> +		err = -errno;
>  		printf(MAIN_PREFIX "can't open %s (write), %s\n", WRITE_FILE,
> -		       strerror(-write_fd));
> +		       strerror(-err));
>  		goto error;
>  	}
>  	write_state |= STATE_FILE_OPENED;
> @@ -254,6 +257,7 @@ int main(int argc, char* argv[])
>  	/* writing write-config */
>  	err = ioctl(write_fd, RTSER_RTIOC_SET_CONFIG, &write_config);
>  	if (err) {
> +		err = -errno;
>  		printf(MAIN_PREFIX "error while RTSER_RTIOC_SET_CONFIG, %s\n",
>  		       strerror(-err));
>  		goto error;
> @@ -263,8 +267,9 @@ int main(int argc, char* argv[])
>  	/* open rtser1 */
>  	read_fd = open( READ_FILE, 0 );
>  	if (read_fd < 0) {
> +		err = -errno;
>  		printf(MAIN_PREFIX "can't open %s (read), %s\n", READ_FILE,
> -		       strerror(-read_fd));
> +		       strerror(-err));
>  		goto error;
>  	}
>  	read_state |= STATE_FILE_OPENED;
> @@ -273,6 +278,7 @@ int main(int argc, char* argv[])
>  	/* writing read-config */
>  	err = ioctl(read_fd, RTSER_RTIOC_SET_CONFIG, &read_config);
>  	if (err) {
> +		err = -errno;
>  		printf(MAIN_PREFIX "error while ioctl, %s\n",
>  		       strerror(-err));
>  		goto error;
> -- 
> 2.1.4
> 

