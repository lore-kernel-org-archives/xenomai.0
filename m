MIME-Version: 1.0
Date: Mon, 11 Aug 2014 11:33:31 -0400
Message-ID: <CAEGbdidABiixUba3TiheYcLx1Swh5TrTbt_FtenZsExq7weUYg@mail.gmail.com>
From: Matthew Lindner <mattlindn@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] C++ std::thread and xenomai pthread
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Has anyone experimented with using std::thread from the C++ STL library? I
am curious if it automatically incorporates the xenomai pthread API layer
or whether it bypasses that and accesses the linux pthread library.

Matthew
