Subject: Re: undefined reference to `rt_task_create
References: <d3c4d944-807a-a2d4-7ec1-2d1639f36f78@vbm-grp.com>
 <48de04a3-9f2c-d3e6-8a80-568a497015c1@vbm-grp.com>
 <5cf98ffb-d244-1030-552e-a1ebed830df0@siemens.com>
 <fbd7a196-5b56-c78b-2b5e-b1c57cb9bdc2@vbm-grp.com>
 <b7ff642f-85d5-a56f-de96-36f3897ddeaa@siemens.com>
 <94d939cd-0274-84bd-62d0-3680f12aebe1@freyder.net>
 <f7f3a089-15fb-6f5b-882f-a79f7e9e183c@siemens.com>
From: "Electronic Dept. - Vbm Group" <electronic@vbm-grp.com>
Message-ID: <e5396119-08a3-f550-e0c2-43aed851d69b@vbm-grp.com>
Date: Fri, 6 Dec 2019 08:39:13 +0100
MIME-Version: 1.0
In-Reply-To: <f7f3a089-15fb-6f5b-882f-a79f7e9e183c@siemens.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello Jan and Steve,

I modified the Makefile as per your indication and now the compiling 
signature is changed as follow:

gcc -o cyclic_test cyclic_test.c -I/usr/xenomai/include/cobalt 
-I/usr/xenomai/include -march=armv7-a -mfpu=vfp3 -D_GNU_SOURCE 
-D_REENTRANT -fasynchronous-unwind-tables -D__COBALT__ 
-I/usr/xenomai/include/alchemy -Wl,--no-as-needed 
-Wl,@/usr/xenomai/lib/modechk.wrappers -lalchemy -lcopperplate 
/usr/xenomai/lib/xenomai/bootstrap.o -Wl,--wrap=main 
-Wl,--dynamic-list=/usr/xenomai/lib/dynlist.ld -L/usr/xenomai/lib 
-lcobalt -lmodechk -lpthread -lrt -march=armv7-a -mfpu=vfp3

Unfortunately as response now I get:
./cyclic_test: error while loading shared libraries: libalchemy.so.0: 
cannot open shared object file: No such file or directory

I've check and inside /usr/xenomai/lib there is:
libalchemy.a
libalchemy.la
libalchemy.so
libalchemy.so.0
libalchemy.so.0.0.0

Thank you again for your assistance.

Best Regards
Davide Brunelli

