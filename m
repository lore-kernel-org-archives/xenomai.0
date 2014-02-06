Message-ID: <52F3A918.3040504@siemens.com>
Date: Thu, 06 Feb 2014 16:24:08 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <E1WAhle-0006kB-0q@sd-51317.dedibox.fr>
 <52F1172B.2080500@xenomai.org> <52F11F94.9000309@siemens.com>
 <52F1231A.7080603@xenomai.org> <52F12442.3040301@xenomai.org>
 <52F125E8.6020200@xenomai.org> <52F12700.3020400@xenomai.org>
 <52F12800.1030500@xenomai.org> <52F12937.3050105@xenomai.org>
 <52F12B7A.4060408@siemens.com> <52F1F749.2030501@xenomai.org>
 <52F1FB24.4090603@siemens.com> <52F1FD3B.1070304@xenomai.org>
 <52F1FEFC.9070708@siemens.com> <52F20604.4020200@xenomai.org>
 <52F20780.9010002@siemens.com> <52F20E32.3010706@xenomai.org>
 <52F2123A.2070607@siemens.com>
In-Reply-To: <52F2123A.2070607@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Xenomai-git] Jan Kiszka : alchemy: Replace static
 variable no_alchemy_task with macro
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 2014-02-05 11:28, Jan Kiszka wrote:
> On 2014-02-05 11:10, Philippe Gerum wrote:
>> On 02/05/2014 10:42 AM, Jan Kiszka wrote:
>>> So you just want me to fold patch 2 and 3 together? I don't fully get it
>>> yet.
>>
>> I'm asking for a clarification: do you have more patches following these
>> two? I understood from the past conversation that more work was
>> required, so I'm assuming you will have. If so, then we may save a lot
>> of time by seeing the complete change set that would fit the bill for
>> supporting standard C/C++ restrictions, the way your current port work
>> seems to require it.
> 
> I'm not aware of further issues after the __typeof__ thing. However, I
> will try to run through all public headers in an automated way,
> including them in strict modes to check if there is something remaining.
> Maybe we can also hook this into our build tests here.

Done this, found 2 more spots regarding typeof, but that's it. What I
tested was this:

#!/bin/bash

XENO_INCLUDE_DIR= \
	`. xeno-config --core >/dev/null; echo $XENO_INCLUDE_DIR`

exclude_patterns="
	\/uapi\/ \
	boilerplate\/private-list.h \
	boilerplate\/shared-list.h"

for f in `find $XENO_INCLUDE_DIR -name *.h`; do
	echo -n "$f - "
	skip=0
	for pattern in $exclude_patterns; do
		if [ "${f/$pattern//}" != "$f" ]; then
			echo "skipped"
			skip=1
			break
		fi
	done
	if [ $skip -ne 0 ]; then
		continue;
	fi
	echo "#include <"${f#include/}">" > .build-test.c
	gcc -Wall -Werror `xeno-config --skin=alchemy --skin=posix \
		--skin=vxworks --skin=psos --cflags` -c .build-test.c \
		-o .build-test.o
	if [ $? != 0 ]; then
		break;
	fi
	echo -n "C "
	g++ -std=c++98 -Wall -Werror `xeno-config --skin=alchemy \
		--skin=posix --skin=vxworks --skin=psos --cflags` \
		-c .build-test.c -o .build-test.o
	if [ $? != 0 ]; then
		break;
	fi
	echo "C++"
	rm -f .build-test.[co]
done

So the patch
http://git.xenomai.org/xenomai-jki.git/commit/?h=for-forge&id=884b5d74df015c39961452965e28a8ec69a92a3c
in for-forge now contains everything required to include all headers in
strict standard mode.
http://git.xenomai.org/xenomai-jki.git/commit/?h=for-forge&id=a79f18bf7254eb91ad64def9b30d6b4f68e9247b
is required already for permissive GCC C++ mode.

Jan

