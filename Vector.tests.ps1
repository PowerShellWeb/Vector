describe Vector {
    it 'It a collection of points' {
        $vector = Vector 1..4 
        $vector.GetType() | Should -Be ([object[]])
        $vector |             
            Should -BeOfType ([int])
    }

    it 'Can be a two dimensional vector' {
        Vector2 3,4 | Should -BeOfType ([Numerics.Vector2])
    }

    it 'Can be a three dimensional vector' {
        Vector3 1,2,3 | Should -BeOfType ([Numerics.Vector3])
    }

    it 'Can be a four dimensional vector' {
        Vector4 1,2,3,4 | Should -BeOfType ([Numerics.Vector4])
    }

    context 'Vector Math' {
        it 'Can subtract vectors' {
            $subtract = (v2 1 2) - (v2 1 2)
            $subtract.X | Should -Be 0
            $subtract.Y | Should -Be 0
        }
        it 'Can add vectors' {
            $add = (v2 1 2) + (v2 1 2)
            $add.X | Should -Be 2
            $add.Y | Should -Be 4
        }
        it 'Can multiply vectors' {
            $multiply = (v2 1 2) * (v2 1 2)
            $multiply.X | Should -Be 1
            $multiply.Y | Should -Be 4
        }
        it 'Can divide vectors' { 
            $divide = (v2 1 2) / (v2 1 2)
            $divide.X | Should -Be 1
            $divide.Y | Should -Be 1
        }
    }
}
