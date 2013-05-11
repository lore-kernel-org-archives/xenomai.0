Message-ID: <518E7659.7080503@xenomai.org>
Date: Sat, 11 May 2013 18:48:25 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <E1UbCuV-0003Mx-J1@xenomai.org>
In-Reply-To: <E1UbCuV-0003Mx-J1@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Xenomai-git] Philippe Gerum : lib/cobalt: use common
 console message prefix
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On 05/11/2013 06:44 PM, git repository hosting wrote:

>  static void sigill_handler(int sig)
>  {
> -	fprintf(stderr, "Xenomai disabled in kernel?\n");
> +	const char *m = "Xenomai disabled in kernel?\n";


I believe you want static const char m[] =
otherwise sizeof(m) will be 4 or 8.

-- 
                                                                Gilles.

