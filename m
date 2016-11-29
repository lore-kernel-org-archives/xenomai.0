References: <bfd126e4fbc87bb85340.1480399086@devws148.be.alcatel-lucent.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <6ad89f47-9acf-90d1-eb99-901643541e61@xenomai.org>
Date: Tue, 29 Nov 2016 09:52:49 +0100
MIME-Version: 1.0
In-Reply-To: <bfd126e4fbc87bb85340.1480399086@devws148.be.alcatel-lucent.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] Mercury/psos: Solve compiler warning when
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

On 11/29/2016 06:58 AM, Ronny Meeus wrote:
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
> This patch solve the above issue creating a string on the stack instead of
> a constant string.
> 

I don't think that using the XPG version of basename() is the right
option; it should not have to modify its argument in the first place.
For this reason, sticking to the GNU version is better. Moving
get_program_name() out of line to boilerplate/setup.c would make more sense.

-- 
Philippe.

