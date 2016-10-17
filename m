Date: Mon, 17 Oct 2016 08:44:58 +0200 (CEST)
From: pierre.roumagnac@free.fr
Message-ID: <2051280157.356274520.1476686698980.JavaMail.root@zimbra19-e3.priv.proxad.net>
In-Reply-To: <fe9b26e5-1aeb-cbe4-789f-38df83f7b4cb@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] [xenomai]:heap memory management
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

For my culture can someone explain me (or provide doc) the difference betwe=
en the memory pool create with --mem_pool_size and the=20
rt_heap_create api of alchemy?
http://xenomai.org/documentation/xenomai-3/html/xeno3prm/group__alchemy__he=
ap.html#ga1d19ad24dc9f94b969aa0f574170bdc4.

Anyway i have set a manual erase of share memory, it looks likes working.
Thanks Philippe for your explanation , really helpfull.

PR

----- Mail original -----
De: "Philippe Gerum" <rpm@xenomai.org>
=C3=80: "pierre roumagnac" <pierre.roumagnac@free.fr>, xenomai@xenomai.org
Envoy=C3=A9: Samedi 15 Octobre 2016 15:54:46
Objet: Re: [Xenomai] [xenomai]:heap memory management

On 10/14/2016 11:45 AM, pierre.roumagnac@free.fr wrote:
> Hello
>=20
> I am currently working on a project running with xenomai 3.0.3 and using =
alchemy skin.
> My context :
>  - i need to use several large size queue using rt_queue_create (more tha=
n 1Mbytes each)
>  - rt_queue_create does not work if i do not set --mem-pool-size option (=
we use 256M value)=20
>=20
> My problem:
>  even if i generate a empty application:
> int main(int argc,char**argv)
> {
>    return 0;
> }
>  my computer free memory drop of 256 MBytes at each application run which=
 is really bothersome when debbuging.
>=20
> Since i do not need shared memory, i have tried to used rt_heap_create / =
rt_heap_delete inside my application.
> But with this solution i cannot create a heap more than 1MBytes which is =
not sufficient for my case.
>=20
> My question is :
>  is there a mean to release shared heap memory ?=20
>  or may be i do not correctly use rt_queue_create?

There seem to be multiple aspects in the issue you describe:

- heap sizes are limited to 2Gb, not 1Mb. 1Mb is the default size of the
memory pool when not specified on the command line via --mem_pool_size;
you could use the trick below to change this value:
http://xenomai.org/2015/05/application-setup-and-init/#changing-default-tun=
able-value

- the fact that your memory pool does not disappear on exit of your
application can only happen in shared mode (--enable-pshared), in that
case the shared pool lives in /dev/shm, consuming pure RAM. The heap may
be left over if your application exits ungracefully and no support for
shared registry is present (--disable-registry). In that case, the
atexit() hook cannot run to clean up the heap, and the registry daemon
won't be there to do this housekeeping work either. A solution for this
situation would be running some out of line cleanup of /dev/shm before
starting an application (maybe from within the application itself).

--=20
Philippe.

