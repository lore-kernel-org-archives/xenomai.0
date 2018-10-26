Subject: Re: improve and provide a header for bootstrapping
References: <20181023151647.25508-1-norbert.lange@andritz.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <7571eedc-7844-2703-e553-72cf9a1abbe0@siemens.com>
Date: Fri, 26 Oct 2018 14:48:50 +0100
MIME-Version: 1.0
In-Reply-To: <20181023151647.25508-1-norbert.lange@andritz.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Norbert Lange <nolange79@gmail.com>, xenomai@xenomai.org

On 23.10.18 16:16, Norbert Lange wrote:
> Hello,
> 
> the following patches allow a variety of options additional
> to the linker magic involved for hijacking the aplications main
> function.
> 
> the original method will still continue to work, differences are
> 
> *   the code dealing with retrieving the commandline arguments
>      is moved into libcobale/libmercury. Making the necessary per-application
>      code much smaller.
> 
> *   the implementation was moved into a header, with several macros
>      controlling functionality (not everyone wants to define a main function).
> 
> 
> The approach I use personally is to compile and link my own bootstrap code,
> which is preferable in many build systems as source-files are understood while
> objects files generally need some special care. (And it cant hurt if the compiler
> flags match exactly).
> 
> As example:
> 
> ----- add this to your file  containing main
> 
> int xenomai_init_getargv(int *argc, char *const** argv);
> 
> int main(int argc, char *const argv[])
> {
> #if defined(__COBALT__) || defined(__MERCURY__)
>      xenomai_init_getargv(&argc, &argv);
> #endif
> 	....
> }
> 
> ----- create another file, lets call it mybootstrap.c
> 
> #define _XENOMAI_BOOTSTRAP_GLIBC_CONSTRUCTORS
> #include <xenomai/bootstrap-template.h>
> 
> ----------------------------------------------
> 
> Norbert
> 
> [PATCH 1/2] separate bootstrap code to get commandline, move it into
> [PATCH 2/2] add a header to create flexible bootstrap code
> 
> 

I need to look more carefully at the details and your use case, but my first 
impression is that at least patch 2 is not very beautiful due to that large 
template header. Could you explain again why explicitly calling the bootstrap 
code in a library is not sufficient?

Also note that this pattern may make it harder to maintain a compatible 
interface along updates, increasing the risk of having to recompile your 
application, rather than just replacing some central library, when Xenomai changes.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

