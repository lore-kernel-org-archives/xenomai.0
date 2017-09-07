References: <CAMJ=MEf5=ZhKBss8GD=ju8efx5GiO_vrGdu1jerW1orpw6+MPw@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <1dac7ec4-2d53-c5d4-0ced-77db95455b56@xenomai.org>
Date: Thu, 7 Sep 2017 11:32:51 +0200
MIME-Version: 1.0
In-Reply-To: <CAMJ=MEf5=ZhKBss8GD=ju8efx5GiO_vrGdu1jerW1orpw6+MPw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] mercury/psos: dump of long message queue causes
 application crash
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ronny Meeus <ronny.meeus@gmail.com>, xenomai@xenomai.org


Maybe you should change your subject line, since the pSOS emulator we
have does not benefit from registry support, only the init stubs are
there. This must be a locally developed extension.

On 08/31/2017 04:02 PM, Ronny Meeus wrote:
> Hello
> 
> I have a test application that creates a psos queue and sends a lot of
> messages to it.
> The application code can be found below.
> 
> Depending on the memory configuration it can be that error are
> generated after some
> time but that is not the issue. When dump the queue in the debug
> interface I see a crash
> of the application:
> 
> /mnt/xenomai/anon/root/anon/11091/psos/queues # cat LINE
> memory exhausted
> cat: can't open 'LINE': Software caused connection abort
> 
> The root-cause of this is that the size of the obstack used in the
> registry is in fact unlimited.
> In case it needs to grow and there is no memory anymore, a handler is
> called that is
> reporting the memory shortage condition and triggers an exit.
> 
> In my opinion it is not correct that this condition triggers an
> application reset. I would rather
> prefer that in case there is a memory shortage, the dump is just
> stopped or that we limit the
> memory that is used worst case in the obstack in the registry.
> 
> The patch below solves the issue but I do not whether it is the right direction.
> Depending on the available memory it might still crash ...
> 
> diff --git a/include/copperplate/registry-obstack.h
> b/include/copperplate/registry-obstack.h
> --- a/include/copperplate/registry-obstack.h
> diff --git a/include/copperplate/registry-obstack.h
> b/include/copperplate/registry-obstack.h
> --- a/include/copperplate/registry-obstack.h
> +++ b/include/copperplate/registry-obstack.h
> @@ -35,6 +35,8 @@ struct syncobj;
>  #define obstack_chunk_alloc    pvmalloc
>  #define obstack_chunk_free     pvfree
> 
> +#define OBSTACK_MAX_SIZE 65536
> +
The general logic looks good, but fixing a hard limit that way for all
objects, all APIs, all platforms and all use cases would be a problem
for obvious reasons.

Instead, this limit could be passed to fsobstack_init() by the API
implementation when opening the registry stream, saving it to struct
fsobstack, exposing it anywhere it is required for enforcing the memory
limit.

-- 
Philippe.

