From: Niklaus Giger <niklaus.giger@domain.hid>
Date: Thu, 11 May 2006 22:42:00 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_YG6YEm000ZkBWuj"
Message-Id: <200605112242.00883.niklaus.giger@domain.hid>
Subject: [Xenomai-core] RFC: Integrate Xenomai's simulator's testsuite into
	the buildbot
Reply-To: niklaus.giger@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

--Boundary-00=_YG6YEm000ZkBWuj
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi

I would like to integrate the output of the Xenomai's simulator's testsuite 
into my buildbot system at htttp://ngiger.dyndns.org/

As I work with a PowerPC system I am still chasing some bugs (Thanks a lot to 
Gilles for his help).

I am interested to know whether an output like the attached 
(12-log-check-sim-log.bz2) produced with my ruby script (attached 
test_sim.rb) is a good idea. Look at the end to get a summary of the 
failed/passed tests. (I have no idea, why the output to standard error 
like "segmentation fault" does not show up instead of the "starting POSIX 
services."). So please tell me if you would like to have some more 
information in the log.

I would appreciate to be able to integrate the same testsuites as part of the 
regression test of all target that use a posix or vxworks skin. I am however 
no specialist in the autotools. Would it be difficult to adapt the Makefile's 
to have the same targets "sim", "std" and "uvm" like in the 
ksrc/skins/<x>/demos?

Are there any other ideas what to test with the simulator? (I do not want to 
to test xenoscope unless somebody can point me to free tool where it is easy 
to setup some interactive tests.)

To test the "distcheck" target is still on my todo list, but with a lower 
priority.

Thanks in advance for all comments.

Best regards
 
-- 
Niklaus Giger

--Boundary-00=_YG6YEm000ZkBWuj
Content-Type: application/x-ruby;
  name="test_sim.rb"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="test_sim.rb"

#!/usr/bin/ruby
# 
#  Copyright (C) 2006 Niklaus Giger
# 
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, Inc., 675 Mass Ave, Cambridge MA 02139,
#  USA; either version 2 of the License, or (at your option) any later
#  version.
# 
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
# 
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
# 
# Utility-Script for the Xenomai buildbot to run all unittest of the xenomai 
# simulator

puts ARGV.inspect 
puts ENV['PWD']
where = Dir.pwd
puts "where ist #{where}"

def callSystem(cmd)
  res=system(cmd)
end

errors = []
passed = []
ENV['LANGUAGE']='C'
ENV['LANG']='C'
[ 'posix', 'vxworks'].each{ |skin|
  Dir.chdir("#{where}/skins/#{skin}/testsuite")
  puts Dir.pwd
  ausgabe = callSystem("make check")
  puts "Ausgabe ist #{ausgabe}"
  puts Dir.glob("t*").inspect
  Dir.glob("t*").each { |f|
    if File.executable?(f) then
      puts "Will call #{f}"
      log = File.expand_path("#{f}.log")
      cmd = "./#{f} 2>&1 | tee #{log}"
      ausgabe = callSystem(cmd)
      content = IO.readlines(log)
      found = false
      line = nil
      logMsg =  "#{skin}->#{f}:"
      content.each { |line|
	errors << logMsg + line if /Expected sequence|failed/.match(line)
        if /finished/.match(line) then
          if / 0 failures/.match(line)
            passed << logMsg + line
          else
            errors << logMsg + line
          end
          found = true
        end
      }
      errors << "#{logMsg}: #{content[-1]}" if !found
    end
  }
}

if passed.size > 0 then
  puts "No problems were reported in:"
  passed.each { |x| puts x }
end

if errors.size == 0 then
  exit 0
else
  puts 
  puts "Some problems were reported in:"
  errors.each { |x| puts x }
  exit 3
end

--Boundary-00=_YG6YEm000ZkBWuj
Content-Type: application/x-bzip2;
  name="12-log-check_sim-log.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="12-log-check_sim-log.bz2"

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
SGqvqKyA

--Boundary-00=_YG6YEm000ZkBWuj--

