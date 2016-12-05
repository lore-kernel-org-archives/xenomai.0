MIME-Version: 1.0
From: Ronny Meeus <ronny.meeus@gmail.com>
Date: Mon, 5 Dec 2016 17:36:09 +0100
Message-ID: <CAMJ=MEfiDuUFduQp7=TgLcNn4NQvr7UKYgS1RrnZMT21+Ohsdg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] Question about the implementation of tunables.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello

we use the pSOS skin over the Mercury core.

I'm preparing a set of patches that introduce new tunables.
What I observe is that in a small test applications it works well but once I
start to use these in our real applications, I observe that the tunables are
not called.

I have identified that the root-cause of this is that we postpone the calling
of the static constructors to a certain point in the application init and call
__do_global_ctors_aux ourselves.
(to make this work our build enviroment uses the -nostartfiles linker option
and some other constructs ...)

Now the question is: are there any option to make this work or have other
people seen similar issues before?
So we should be able to call the static constructors of the tunables only
before we call copperplate_init ...


Ronny

