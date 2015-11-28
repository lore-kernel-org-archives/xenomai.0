Date: Sat, 28 Nov 2015 14:30:02 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151128133002.GE10399@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Xenomai] https access
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Hi,

as people have probably noticed, Xenomai website and git repository
web interface are available using either the http or https protocol.
We do not redirect http to https so that people wishing to continue
using http can do so.

However, if you wish to force your navigator to use the https
protocol, a simple solution exists: the EFF "https everywhere"
add-on. I submitted a ruleset for Xenomai site to this project,
however a new version of the add-on has not been released since. So,
in the mean time, you can install the add-on and manually add the
following ruleset (with firefox, you do that by creating a file
named Xenomai.org.xml under the HTTPSEverywhereUserRules
subdirectory of your firefox profile directory):

<ruleset name="Xenomai.org">
  <target host="xenomai.org" />
  <target host="www.xenomai.org" />
  <target host="git.xenomai.org" />

  <rule from="^http:" to="https:" />
</ruleset>

Regards.

-- 
					    Gilles.
https://click-hack.org

