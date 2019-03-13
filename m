From: Norbert Lange <nolange79@gmail.com>
Subject: Rework __ctz and __clz macros
Date: Wed, 13 Mar 2019 18:16:30 +0100
Message-Id: <20190313171632.5276-1-norbert.lange@andritz.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Those are commonly used in Frameworks (eg libc++),
This series renamed __ctz and replaces the __clz
with something simpler that could be evaluated in constant
contexts aswell (and doesnt use GCC statement expressions).

Ideally though these would be moved out of the public header
into something private for the xenomai build.



