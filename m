MIME-Version: 1.0
From: Ronny Meeus <ronny.meeus@gmail.com>
Date: Fri, 8 Mar 2013 15:16:12 +0100
Message-ID: <CAMJ=MEdBofo5+uaFiTLpEE6mHaFhEit=Ae=i=05wu0+fydo2=g@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] xenomai-forge: Interface change of copperplate_init
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello

I see that the interface of copperplate_init has been changed from:

void copperplate_init(int argc, char *const argv[]);
to
void copperplate_init(int *argcp, char *const **argvp);

This is disturbing if I have an application that needs to be run on
the 2 versions of xenomai.
Is there any construction (for example a define) I can use in my code
to call this function in a correct way?


Ronny.

