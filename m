MIME-Version: 1.0
From: Antoine Hoarau <antoine@flr.io>
Date: Fri, 14 Feb 2020 10:48:04 +0100
Message-ID: <CAPnNZ0UJEFhQXnmkH=RyBWVuXWiymw-S3jCcH+U5B_1VESALJA@mail.gmail.com>
Subject: undefined symbol in tests
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

If I run xeno tests I get :
symbol lookup error: /usr/lib/libalchemy.so.0: undefined symbol: __real_free
/usr/lib/xenomai/testsuite/smokey: test dlopen failed: Unknown error -127
child 1458 returned: exited with status 1

Tests on 3.1 release.
