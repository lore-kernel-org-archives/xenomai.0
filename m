References: <etPan.595c4255.66334873.12c6@rtxi.org>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <fa2c6107-af96-257a-0719-1b40173d30fe@xenomai.org>
Date: Wed, 5 Jul 2017 08:39:52 +0200
MIME-Version: 1.0
In-Reply-To: <etPan.595c4255.66334873.12c6@rtxi.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Missing ipipe files in tarballs
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Yogi A. Patel" <yogi@rtxi.org>, xenomai@xenomai.org

On 07/05/2017 03:26 AM, Yogi A. Patel wrote:
> FYI - The tarballs for 3.0.4 and 3.0.5 are missing the patch folder.
> 

This is intended, and the README in such folder states clearly where to
find them instead [1].

The reason is that way too many people have assumed in the past that
only the set of patches shipped with a release could be used with that
particular release, which is wrong. At the end of the day, they would
stick to outdated I-pipe code with known bugs instead of upgrading their
setup, which is counter-productive, including for the folks who spend
time trying to help them on this list.

[1] http://xenomai.org/downloads/ipipe/

-- 
Philippe.

