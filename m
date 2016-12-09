References: <1bcdb8054ee593a62d4b.1480428239@devws148.be.alcatel-lucent.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <01dfc057-b2a4-6521-7f5b-efa65269ef1c@xenomai.org>
Date: Fri, 9 Dec 2016 15:44:10 +0100
MIME-Version: 1.0
In-Reply-To: <1bcdb8054ee593a62d4b.1480428239@devws148.be.alcatel-lucent.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH v2] psos.h: remove dependency on tunables.h
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ronny Meeus <ronny.meeus@gmail.com>, xenomai@xenomai.org

On 11/29/2016 03:03 PM, Ronny Meeus wrote:
> The psos.h file pollutes the application's namespace with defines
> of the boilerplate code because the tunables.h is included. In our
> application we already have a definition of the list_entry macro,
> resulting in a redefinition. The psos.h should be kept clean.

Merged, thanks.

-- 
Philippe.

