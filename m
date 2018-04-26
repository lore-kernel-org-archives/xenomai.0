From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <ad4d0f53-1c4c-1c5d-44f0-38721eff2bc1@xenomai.org>
Date: Thu, 26 Apr 2018 12:20:14 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [BUG] critical bug fixed in the shared heap memory
	allocator
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <Xenomai@xenomai.org>


If you rely on --enable-pshared, i.e. having a multi-process application
sharing a central heap, you do want to pick this fix:

http://git.xenomai.org/xenomai-3.git/commit/?id=984d13432547d9cb9283162e3efd6b2224acb2a9

-- 
Philippe.

