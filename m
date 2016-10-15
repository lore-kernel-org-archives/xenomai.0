References: <231871933.347097737.1476438337896.JavaMail.root@zimbra19-e3.priv.proxad.net>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <fe9b26e5-1aeb-cbe4-789f-38df83f7b4cb@xenomai.org>
Date: Sat, 15 Oct 2016 15:54:46 +0200
MIME-Version: 1.0
In-Reply-To: <231871933.347097737.1476438337896.JavaMail.root@zimbra19-e3.priv.proxad.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [xenomai]:heap memory management
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: pierre.roumagnac@free.fr, xenomai@xenomai.org

On 10/14/2016 11:45 AM, pierre.roumagnac@free.fr wrote:
> Hello
> 
> I am currently working on a project running with xenomai 3.0.3 and using alchemy skin.
> My context :
>  - i need to use several large size queue using rt_queue_create (more than 1Mbytes each)
>  - rt_queue_create does not work if i do not set --mem-pool-size option (we use 256M value) 
> 
> My problem:
>  even if i generate a empty application:
> int main(int argc,char**argv)
> {
>    return 0;
> }
>  my computer free memory drop of 256 MBytes at each application run which is really bothersome when debbuging.
> 
> Since i do not need shared memory, i have tried to used rt_heap_create / rt_heap_delete inside my application.
> But with this solution i cannot create a heap more than 1MBytes which is not sufficient for my case.
> 
> My question is :
>  is there a mean to release shared heap memory ? 
>  or may be i do not correctly use rt_queue_create?

There seem to be multiple aspects in the issue you describe:

- heap sizes are limited to 2Gb, not 1Mb. 1Mb is the default size of the
memory pool when not specified on the command line via --mem_pool_size;
you could use the trick below to change this value:
http://xenomai.org/2015/05/application-setup-and-init/#changing-default-tunable-value

- the fact that your memory pool does not disappear on exit of your
application can only happen in shared mode (--enable-pshared), in that
case the shared pool lives in /dev/shm, consuming pure RAM. The heap may
be left over if your application exits ungracefully and no support for
shared registry is present (--disable-registry). In that case, the
atexit() hook cannot run to clean up the heap, and the registry daemon
won't be there to do this housekeeping work either. A solution for this
situation would be running some out of line cleanup of /dev/shm before
starting an application (maybe from within the application itself).

-- 
Philippe.

