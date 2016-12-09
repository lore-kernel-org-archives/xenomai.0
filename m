References: <eb3a38210523ca36c62c.1480425966@devws148.be.alcatel-lucent.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <8e82334e-9e04-6774-670b-bc0459a200a0@xenomai.org>
Date: Fri, 9 Dec 2016 15:43:48 +0100
MIME-Version: 1.0
In-Reply-To: <eb3a38210523ca36c62c.1480425966@devws148.be.alcatel-lucent.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH v2] Mercury/psos: Solve compiler warning when
 including psos.h
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ronny Meeus <ronny.meeus@gmail.com>, xenomai@xenomai.org

On 11/29/2016 02:26 PM, Ronny Meeus wrote:
> In boilerplate function 'get_program_name', basename is used.
> 
> When libgen.h is incuded in your program, the basename gets the POSIX
> version (no const char*, see 'man basename'):
> char *basename(char *path);
> 
> This results in the following compiler warning:
> boilerplate/setup.h: In function 'const char* get_program_name()':
> boilerplate/setup.h:107: error: invalid conversion from 'const char*' to 'char*'
> boilerplate/setup.h:107: error:   initializing argument 1 of 'char* __xpg_basename(char*)'
> 
> Test application:
> 
> #include <libgen.h>
> #include <psos/psos.h>
> int main(int argc, char * const argv[])
> {
>   return 0;
> }
> 
> When the libgen.h is not included, the warning is not seen.
> 
> This patch solve the above issue by moving the implementation to setup.c
> instead of using an inline function.

Merged, thanks.

-- 
Philippe.

