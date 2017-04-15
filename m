References: <20170414175411.11952-1-gokturk@gentoo.org>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <c1503859-fe27-6b50-164d-89d91cb55509@xenomai.org>
Date: Sat, 15 Apr 2017 16:49:13 +0200
MIME-Version: 1.0
In-Reply-To: <20170414175411.11952-1-gokturk@gentoo.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] [PATCH v1] configure: fix the help string for demodir
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?R8O2a3TDvHJrIFnDvGtzZWs=?= <gokturk@gentoo.org>, xenomai@xenomai.org

On 04/14/2017 07:54 PM, G=F6kt=FCrk Y=FCksek wrote:
> The help string uses '--with-demo' instead of '--with-demodir',
> misinforming the user about the correct option to pass.
> ---
>  configure.ac | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/configure.ac b/configure.ac
> index 4792e46..d6354f1 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -746,7 +746,7 @@ AC_MSG_RESULT($XENO_TEST_DIR)
>  demodir=3D'${exec_prefix}/demo'
>  AC_MSG_CHECKING(location for demo programs)
>  AC_ARG_WITH(demodir,
> -    AS_HELP_STRING([--with-demo=3D<demo-program-dir>],[location for demo=
 programs (defaults to $prefix/demo)]),
> +    AS_HELP_STRING([--with-demodir=3D<demo-program-dir>],[location for d=
emo programs (defaults to $prefix/demo)]),
>      [
>  	case "$withval" in
>  	"" | y | ye | yes | n | no)
>=20

Merged, thanks.

--=20
Philippe.

