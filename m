Message-ID: <506EB20A.5010107@xenomai.org>
Date: Fri, 05 Oct 2012 12:10:18 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <506EACBD.8090307@wanadoo.fr>
In-Reply-To: <506EACBD.8090307@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] nanosleep and clock_nanosleep increase MSW counter
 without SIGXCPU
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Thierry Bultel <thierry.bultel@wanadoo.fr>
Cc: xenomai@xenomai.org

On 10/05/2012 11:47 AM, Thierry Bultel wrote:
> Hi,
> 
> My config is linux-3.2.21+xenomai-2.6.1 ; ipipe-core-3.2.21-arm-1.patch,
> on qemu-system-arm ; versatile express. I have CONFIG_SMP to NO
> 
> My test case is quite simple.
> The main process is as such:
> 
> -----------------
> 
> int main ( ......
> 
> 
> pthread_set_name_np(pthread_self(), "MAIN PROCESS");
> 
> if (pthread_set_mode_np(0, PTHREAD_WARNSW) != 0)
> {
>     LOG("pthread_set_mode_np FAILED\n");
>     exit(0);
> }
> 
> for (;;)
> {
>     struct timespec delay = { 10, 0 };
>     nanosleep(&delay,NULL);
> }

mlockall missing.

-- 
					    Gilles.

